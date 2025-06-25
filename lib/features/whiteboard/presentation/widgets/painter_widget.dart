import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';

class WhiteboardPainter extends CustomPainter {
  final List<DrawingPointEntity> drawingPoints;

  WhiteboardPainter({this.drawingPoints = const []});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawing in drawingPoints) {
      if (drawing.recDrawing != null && drawing.position != null) {
        // Draw recognized text
        final textSpan = TextSpan(
          text: drawing.recDrawing?.recDrawing as String,
          style: TextStyle(color: Colors.blue, fontSize: 16),
        );
        final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, drawing.position!.topLeft);
      } else {
        canvas.drawPoints(PointMode.polygon, drawing.points, drawing.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
