import 'dart:ui';

class CalculateBoundingBoxUtils {
  static Rect calculateBoundingBox(List<List<Offset>> strokes) {
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final stroke in strokes) {
      for (final point in stroke) {
        minX = point.dx < minX ? point.dx : minX;
        minY = point.dy < minY ? point.dy : minY;
        maxX = point.dx > maxX ? point.dx : maxX;
        maxY = point.dy > maxY ? point.dy : maxY;
      }
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}
