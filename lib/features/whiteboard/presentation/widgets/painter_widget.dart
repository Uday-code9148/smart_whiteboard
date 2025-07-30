import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/enums/category_enum.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/enums/shapes_enum.dart';

class WhiteboardPainter extends CustomPainter {
  final List<DrawingPointEntity> drawingPoints;

  WhiteboardPainter({this.drawingPoints = const []});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawing in drawingPoints) {
      final paint = drawing.paint ?? Paint()
        ..color = Colors.black
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      if (drawing.recDrawing != null && drawing.position != null) {
        final textContent = drawing.recDrawing?.recDrawing?.toString() ?? '';
        final textSpan = TextSpan(
          text: textContent,
          style: const TextStyle(color: Colors.blue, fontSize: 16),
        );
        final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, drawing.position!.topLeft);
      } else if (drawing.categoryEnum == CategoryEnum.pen) {
        if (drawing.points.length >= 2) {
          canvas.drawPoints(PointMode.polygon, drawing.points, paint);
        }
      } else if (drawing.categoryEnum == CategoryEnum.customShape && drawing.shape != null && drawing.points.length >= 2) {
        final points = drawing.points;

        switch (drawing.shape!) {
          case ShapesEnum.line:
            canvas.drawLine(points.first, points.last, paint);
            break;

          case ShapesEnum.rectangle:
          case ShapesEnum.square:
            final start = points.first;
            final end = points.last;
            final rect = Rect.fromPoints(start, end);
            final finalRect = drawing.shape == ShapesEnum.square ? _squareFromRect(rect) : rect;
            canvas.drawRect(finalRect, paint);
            break;

          case ShapesEnum.circle:
            final center = (points.first + points.last) / 2;
            final radius = (points.first - points.last).distance / 2;
            canvas.drawCircle(center, radius, paint);
            break;

          case ShapesEnum.ellipse:
            final rect = Rect.fromPoints(points.first, points.last);
            canvas.drawOval(rect, paint);
            break;

          case ShapesEnum.triangle:
            final path = Path();
            final p1 = points.first;
            final p2 = points.last;
            final p3 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy - (p2.dy - p1.dy).abs());
            path.moveTo(p1.dx, p2.dy);
            path.lineTo(p2.dx, p2.dy);
            path.lineTo(p3.dx, p3.dy);
            path.close();
            canvas.drawPath(path, paint);
            break;

          case ShapesEnum.arrow:
            _drawArrow(canvas, points.first, points.last, paint);
            break;
        }
      }
    }
  }

  Rect _squareFromRect(Rect rect) {
    final side = rect.shortestSide;
    return Rect.fromLTWH(rect.left, rect.top, side, side);
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    // Main arrow shaft
    canvas.drawLine(start, end, paint);

    const double arrowSize = 10;
    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);

    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowSize * math.cos(angle - math.pi / 6), end.dy - arrowSize * math.sin(angle - math.pi / 6))
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - arrowSize * math.cos(angle + math.pi / 6), end.dy - arrowSize * math.sin(angle + math.pi / 6));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WhiteboardPainter oldDelegate) {
    return oldDelegate.drawingPoints != drawingPoints;
  }
}
