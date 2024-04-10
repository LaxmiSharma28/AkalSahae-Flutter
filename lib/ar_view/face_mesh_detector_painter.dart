import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui' as ui;
import 'coordinates_translator.dart';

class FaceMeshDetectorPainter extends CustomPainter {
  FaceMeshDetectorPainter(
      this.meshes,
      this.imageSize,
      this.rotation,
      this.cameraLensDirection,
      this.filterImage,
      );

  final List<FaceMesh> meshes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final ui.Image filterImage;
  @override
  void paint(Canvas canvas, Size size) {
    // final Paint paint1 = Paint()
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 1.0
    //   ..color = Colors.red;

    for (final FaceMesh mesh in meshes) {
      final left = translateX(
        mesh.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        mesh.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      // final right = translateX(
      //   mesh.boundingBox.right,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );
      // final bottom = translateY(
      //   mesh.boundingBox.bottom,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );

      //canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint1);
      // final topLeftCorner = Offset(left, top);
      // canvas.drawCircle(topLeftCorner, 5.0, paint1);
      // final topRightCorner = Offset(right, top);
      // canvas.drawCircle(topRightCorner, 5.0, paint1);


      var offset = Offset(left, top);
      canvas.drawImage(filterImage, offset-Offset(230,125), Paint());
    }
  }


  @override
  bool shouldRepaint(FaceMeshDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.meshes!= meshes;
  }


}




/*
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_mesh_detection/google_mlkit_face_mesh_detection.dart';
import 'coordinates_translator.dart';

class FaceMeshDetectorPainter extends CustomPainter {
  FaceMeshDetectorPainter(
      this.meshes,
      this.imageSize,
      this.rotation,
      this.cameraLensDirection,
      );

  final List<FaceMesh> meshes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.blue;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;

    for (final FaceMesh mesh in meshes) {
      final left = translateX(
        mesh.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        mesh.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        mesh.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        mesh.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right,600),
        paint1,
      );
      void paintTriangle(FaceMeshTriangle triangle) {
        final List<Offset> cornerPoints = <Offset>[];
        for (final point in triangle.points) {
          final double x = translateX(
            point.x.toDouble(),
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          );
          final double y = translateY(
            point.y.toDouble(),
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          );

          cornerPoints.add(Offset(x, y));
        }
        cornerPoints.add(cornerPoints.first);
        canvas.drawPoints(PointMode.lines, cornerPoints, paint2);
      }


      for (final triangle in mesh.triangles) {
        paintTriangle(triangle);
      }
    }
  }

  @override
  bool shouldRepaint(FaceMeshDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.meshes != meshes;
  }
}*/
