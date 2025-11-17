import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class BoxCameraWidget extends StatefulWidget {
  final Function(List<int>) onTakePicture;
  const BoxCameraWidget({super.key, required this.onTakePicture});

  @override
  State<BoxCameraWidget> createState() => _BoxCameraWidgetState();
}

class _BoxCameraWidgetState extends State<BoxCameraWidget> {
  final GlobalKey previewKey = GlobalKey();
  final renderer = RTCVideoRenderer();
  MediaStream? _stream;
  bool isStreaming = false;

  @override
  void initState() {
    renderer.initialize();
    startCamera();
    super.initState();
  }

  @override
  void dispose() {
    stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepaintBoundary(
          key: previewKey,
          child: Container(
            width: 600,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: RTCVideoView(renderer, mirror: true),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () async {
            List<int> byteImage = await captureAndUpload();
            widget.onTakePicture(byteImage);
          },
          icon: const Icon(
            Icons.camera_alt,
            color: Color.fromARGB(255, 204, 204, 204),
          ),
          label: const Text(
            'Ambil Gambar',
            style: TextStyle(color: Color.fromARGB(255, 204, 204, 204)),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
        ),
      ],
    );
  }

  Future<void> startCamera() async {
    try {
      final stream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': {'facingMode': 'user', 'width': 640, 'height': 480},
      });
      setState(() {
        _stream = stream;
        renderer.srcObject = stream;
        isStreaming = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal buka kamera: $e')));
      }
    }
  }

  Future<void> stopCamera() async {
    _stream?.getTracks().forEach((track) => track.stop());
    renderer.srcObject = null;
    renderer.dispose();
  }

  Future<List<int>> captureAndUpload() async {
    RenderRepaintBoundary boundary =
        previewKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }
}
