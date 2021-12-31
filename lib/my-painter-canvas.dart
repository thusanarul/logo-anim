import 'package:flutter/material.dart';
import 'dart:math';

import 'particle.dart';

Offset PolarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;

  MyPainterCanvas(this.particles, this.rgn, this.animValue);
  @override
  void paint(Canvas canvas, Size size) {
    for (Particle p in particles) {
      Offset velocity = PolarToCartesian(p.speed, p.theta);
      double dx = p.position.dx + velocity.dx;
      double dy = p.position.dy + velocity.dy;
      if (dx < 0 || dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }

      if (dy < 0 || dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    }

    for (Particle p in particles) {
      Paint paint = Paint();
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }

    double dx = size.width / 2;
    double dy = size.height / 2;

    Offset c = Offset(dx, dy);
    Paint paint = Paint();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
