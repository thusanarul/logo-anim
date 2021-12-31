import 'dart:math';

import 'package:flutter/material.dart';

import 'my-painter-canvas.dart';
import 'particle.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    particles = List<Particle>.generate(100, (index) {
      Particle p = Particle();
      p.color = Colors.black;
      p.position = const Offset(-1, -1);
      p.speed = rgn.nextDouble() * 2.0;
      p.theta = rgn.nextDouble() * 2.0 * pi;

      p.radius = rgn.nextDouble() * 10;

      return p;
    });

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
            foregroundPainter: MyPainterCanvas(particles, rgn, animation.value),
            child: Container()));
  }
}
