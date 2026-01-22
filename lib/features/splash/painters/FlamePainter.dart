import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class FlamePainter extends CustomPainter {
  final ui.Image image;
  final Duration elapsed;
  final double exitProgress;

  FlamePainter(this.image, this.elapsed, this.exitProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..filterQuality = FilterQuality.none;

    final t = elapsed.inMilliseconds;
    final step = (t ~/ 150) % 9;

    final intensity = 1.0 - exitProgress;
    final dx = ((step % 3) - 1) * intensity;
    final dy = ((step ~/ 3) - 1) * intensity;

    canvas.translate(dx, dy);
    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}
