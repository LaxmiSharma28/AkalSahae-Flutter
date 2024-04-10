import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DragImage extends StatefulWidget {
  DragImage({super.key, this.image});

  String? image;

  @override
  State<DragImage> createState() => _DragImageState();
}

class _DragImageState extends State<DragImage> {
  Image image = Image.asset('assets/images/logo.png');
  var setImage;
  Offset setOffset = const Offset(100, 100);
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(File(widget.image.toString()))
                //child: Image.asset("assets/images/man1.png"),
                ),
            Positioned(
              top: setOffset.dy,
              left: setOffset.dx,
              child: Container(
                child: Transform.scale(
                  scale: _scaleFactor,
                  child:
                      //Image.file(File(widget.image.toString()))

                      Image.asset(
                    'assets/images/turban.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              // onPanUpdate: (details) {
              //   setOffset = Offset(details.globalPosition.dx, details.globalPosition.dy);
              //   setState(() {});
              // },
              onScaleStart: (details) {
                _baseScaleFactor = _scaleFactor;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scaleFactor = _baseScaleFactor * details.scale;

                  if (details.pointerCount == 1 && _baseScaleFactor == _scaleFactor) {
                    setOffset = Offset(details.focalPoint.dx - 75, details.focalPoint.dy - 75);
                  }
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.01),
              ),
            ),
            Positioned(
                top: 40,
                left: 8,
                child:SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 20,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class DragAndScaleWidget extends StatefulWidget {
  Function(double scale, Offset offset, double angle) dragUpdate;

  DragAndScaleWidget({super.key, required this.dragUpdate});

  @override
  _DragAndScaleWidgetState createState() => _DragAndScaleWidgetState();
}

class _DragAndScaleWidgetState extends State<DragAndScaleWidget> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _previousScale = _scale;
        _previousOffset = _offset;
      },
      onScaleUpdate: (details) {
        setState(() {
          // Calculate the new scale based on the previous scale and the scale update
          _scale = _previousScale * details.scale;
          widget.dragUpdate(details.rotation, _previousOffset, _previousScale);
          // Calculate the new offset based on the previous offset and the focal point of the scale update
          _offset = _previousOffset + (details.focalPoint - details.localFocalPoint);
        });
      },
      child: Transform(
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0)..scale(_scale),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ),
    );
  }
}
