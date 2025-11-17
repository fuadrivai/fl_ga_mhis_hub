import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  bool _isStreaming = false;
  final GlobalKey _previewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
  }

  @override
  void dispose() {
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
        _isStreaming = true;
      });
    } catch (e) {
      debugPrint('Error starting camera: $e');
    }
  }

  Future<void> _stopCamera() async {
    _localStream?.getTracks().forEach((t) => t.stop());
    setState(() {
      _localRenderer.srcObject = null;
      _isStreaming = false;
    });
  }

  Future<void> _captureFrame() async {
    try {
      RenderRepaintBoundary boundary =
          _previewKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/capture_${DateTime.now().millisecondsSinceEpoch}.png';
      await File(filePath).writeAsBytes(pngBytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('📸 Foto tersimpan di $filePath')),
        );
      }
    } catch (e) {
      debugPrint('Error capturing frame: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Realtime Camera (flutter_webrtc)')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _previewKey,
                child: Container(
                  width: 640,
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
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            children: [
              ElevatedButton.icon(
                onPressed: _isStreaming ? null : _startCamera,
                icon: const Icon(Icons.videocam),
                label: const Text('Start Camera'),
              ),
              ElevatedButton.icon(
                onPressed: _isStreaming ? _stopCamera : null,
                icon: const Icon(Icons.stop),
                label: const Text('Stop'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isStreaming ? _captureFrame : null,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
