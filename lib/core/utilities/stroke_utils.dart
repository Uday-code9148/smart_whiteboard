import 'dart:ui';

import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as mlkit;

class StrokeUtils {
  /// Converts a list of strokes (each stroke is a list of Offset points)
  /// into an MLKit Ink object for handwriting recognition.
  static mlkit.Ink buildInkFromOffsets(List<List<Offset>> strokes) {
    final ink = mlkit.Ink();
    final inkStrokes = <mlkit.Stroke>[];

    for (final stroke in strokes) {
      final inkStroke = mlkit.Stroke();
      inkStroke.points = stroke.map((point) {
        return mlkit.StrokePoint(x: point.dx, y: point.dy, t: DateTime.now().millisecondsSinceEpoch);
      }).toList();
      inkStrokes.add(inkStroke);
    }

    ink.strokes = inkStrokes;
    return ink;
  }
}
