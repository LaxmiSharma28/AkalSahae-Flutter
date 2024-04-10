// ignore_for_file: unnecessary_null_comparison

import 'dart:ui'as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_mesh_detection/google_mlkit_face_mesh_detection.dart';
import 'detector_view.dart';
import 'face_mesh_detector_painter.dart';


class FaceMeshDetectorView extends StatefulWidget {
  @override
  State<FaceMeshDetectorView> createState() => _FaceMeshDetectorViewState();
}

class _FaceMeshDetectorViewState extends State<FaceMeshDetectorView> {
  @override
  void initState() {
    loadFilterImage();
    super.initState();
  }

  final FaceMeshDetector _meshDetector = FaceMeshDetector(option: FaceMeshDetectorOptions.faceMesh);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;
  ui.Image? filterImage;

  void loadFilterImage() async {
    final data = await rootBundle.load('assets/images/turban.png');
    final codec = await ui.instantiateImageCodec(Uint8List.sublistView(data.buffer.asUint8List()),targetHeight: 250,targetWidth: 270);
    final info = await codec.getNextFrame();
    filterImage = info.image;
    print("image--->>>${filterImage}");
  }

  // void loadFiltersImage(FaceMesh mesh) async {
  //   if (mesh == null) {
  //     return;
  //   }
  //   final data = await rootBundle.load('assets/images/turban.png');
  //   final faceWidth = mesh.boundingBox.width;
  //
  //   final targetWidth = faceWidth * 2.0;
  //   final targetHeight = targetWidth;
  //
  //   final codec = await ui.instantiateImageCodec(
  //     Uint8List.sublistView(data.buffer.asUint8List()),
  //     targetHeight: targetHeight.toInt(),
  //     targetWidth: targetWidth.toInt(),
  //   );
  //   final info = await codec.getNextFrame();
  //   filterImage = info.image;
  //   print("image--->>>${filterImage}");
  // }

  @override
  void dispose() {
    _canProcess = false;
    _meshDetector.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // if (Platform.isIOS) {
    //   return Scaffold(
    //     appBar: AppBar(title: const Text('Under construction')),
    //     body: const Center(
    //         child: Text(
    //           'Not implemented yet for iOS :(\nTry Android',
    //           textAlign: TextAlign.center,
    //         )),
    //   );
    // }
    return DetectorView(
      title: 'Face Mesh Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final meshes = await _meshDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceMeshDetectorPainter(
        meshes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
          filterImage!,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Face meshes found: ${meshes.length}\n\n';
      for (final mesh in meshes) {
        text += 'face: ${mesh.boundingBox}\n\n';
      }
      _text = text;

      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
