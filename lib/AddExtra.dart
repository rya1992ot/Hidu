import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';



late List<Widget> extra = [Container()];

class AddExtra {
  final width = 60.0;
  final height = 60.0;
  bool accepted = false;
  bool moreSticker = false;
  late String data1;
  late String file;

  late Matrix4? matrix;
  late ValueNotifier<Matrix4?> notifier;

  void addExtra() {
    matrix = Matrix4.identity();
    notifier = ValueNotifier(matrix);

    extra.add(Center(
      child: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          matrix = MatrixGestureDetector.compose(matrix!, tm, sm, rm);
          notifier.value = matrix;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
              transform: matrix!,
              child: Center(
                child: Transform.scale(
                    scale: 1,
                    origin: Offset(0.0, 0.0),
                    child: accepted == true
                        ? Center(
                            child: Image.asset(
                              data1,
                              height: height,
                              width: width,
                            ),
                          )
                        : Container(
                            child: moreSticker == false
                                ? Container()
                                : Image.asset(
                                    file,
                                    height: height,
                                    width: width,
                                  ),
                          )),
              ),
            );
          },
        ),
      ),
    ));
  }

  buildOneByOne(BuildContext context) {
    return extra.map<Widget>((Widget item) => item).map((e) => e);
  }
}
