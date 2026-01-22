import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/embers.dart';

class EmberPainter extends CustomPainter {
  final List<Ember> embers;
  final double dt;
  final bool exiting;
  final math.Random rng;

  EmberPainter(this.embers, this.dt, this.exiting, this.rng);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..filterQuality = FilterQuality.none
      ..color = const Color(0xFFFFC857);

    for (final ember in embers) {
      ember.y -= ember.speed * dt;
      ember.x += ember.drift * dt;
      ember.life += dt;

      final alpha = (1.0 - ember.life).clamp(0.0, 1.0);
      paint.color = paint.color.withOpacity(alpha);

      final baseX = size.width / 2;
      final baseY = size.height;

      canvas.drawRect(
        Rect.fromLTWH(
          baseX + ember.x,
          baseY + ember.y,
          3,
          3,
        ),
        paint,
      );

      if (ember.life > 1.0 && !exiting) {
        ember
          ..x = (rng.nextDouble() * 16) - 8
          ..y = rng.nextDouble() * 10
          ..life = 0;

      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
