import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApasdp extends StatelessWidget {
  const MyApasdp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomPaint(
            painter: LinePainter(),
            size: const Size(100, 100), // adjust canvas size
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final points = [
      Offset(0.0, 0.0),
      Offset(28.8, 0.0),
      Offset(57.6, 0.0),
      Offset(86.4, 0.0),
    ];

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}