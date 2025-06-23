import 'package:flutter/material.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';

class WhiteboardPainter extends CustomPainter {
  final List<DrawingPointEntity> drawingPoints;

  WhiteboardPainter({this.drawingPoints = const []});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      final current = drawingPoints[i];
      final next = drawingPoints[i + 1];

      if (current.points != null && next.points != null) {
        canvas.drawLine(current.points!, next.points!, current.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
