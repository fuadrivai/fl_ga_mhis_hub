import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/attendance_screen.dart';
import 'package:fl_ga_mhis_hub/page/repository/employee_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CameraPage extends StatefulWidget {
  final Employee employee;
  const CameraPage({super.key, required this.employee});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  final GlobalKey _previewKey = GlobalKey();
  bool _isProcessing = false;

  bool get _isStreaming => _localStream != null;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _localRenderer.initialize();
    if (!mounted) return;
    await _startCamera();
  }

  @override
  void dispose() {
    _localStream?.getTracks().forEach((t) => t.stop());
    _localRenderer.srcObject = null;
    _localRenderer.dispose();
    _localStream?.dispose();
    super.dispose();
  }

  Future<void> _startCamera() async {
    try {
      final stream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': {'width': 1280, 'height': 720, 'facingMode': 'user'},
      });
      setState(() {
        _localStream = stream;
        _localRenderer.srcObject = stream;
      });
    } catch (e) {
      debugPrint('Error starting camera: $e');
    }
  }

  Future<void> _captureFrame() async {
    if (_isProcessing) return;

    final employeeId = widget.employee.id;
    if (employeeId == null) {
      _showSnackBar('Employee ID tidak ditemukan', isError: true);
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final renderObject = _previewKey.currentContext?.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) {
        throw Exception('Preview kamera belum siap');
      }

      final boundary = renderObject;
      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception('Gagal membaca hasil tangkapan kamera');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final String base64Image = base64Encode(pngBytes);

      final result = await EmployeeApi.postFaceApi({
        'employee_id': employeeId,
        'image': base64Image,
      });

      if (!mounted) return;

      final successMessage =
          (result is Map && (result['message']?.toString().isNotEmpty ?? false))
          ? result['message'].toString()
          : 'Foto berhasil diupload';
      _showSnackBar(successMessage);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AttendanceScreen()),
        (route) => false,
      );
    } catch (e) {
      if (mounted) {
        _showSnackBar('Gagal upload foto: $e', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Update Foto Karyawan')),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: RepaintBoundary(
                  key: _previewKey,
                  child: Container(
                    width: 680,
                    height: 480,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: RTCVideoView(_localRenderer, mirror: true),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isStreaming && !_isProcessing
                    ? _captureFrame
                    : null,
                icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                label: const Text(
                  'Ambil Gambar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400,
                  disabledForegroundColor: Colors.white70,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          if (_isProcessing)
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.35),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        'Memproses foto...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
