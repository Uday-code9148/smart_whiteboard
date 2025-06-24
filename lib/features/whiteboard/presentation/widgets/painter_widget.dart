import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';

class WhiteboardPainter extends CustomPainter {
  final List<DrawingPointEntity> drawingPoints;

  WhiteboardPainter({this.drawingPoints = const []});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawing in drawingPoints) {
      canvas.drawPoints(PointMode.polygon, drawing.points, drawing.paint!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
