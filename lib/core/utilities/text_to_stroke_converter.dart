import 'package:flutter/material.dart';

class TextToStrokeConverter {
  static Future<List<Offset>> getTextOffsetsUsingTextPainter(String text) async {
    final textStyle = TextStyle(fontSize: 80, color: Colors.black);

    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();

    final path = textPainter.getOffsetForCaret(TextPosition(offset: 0), Rect.zero);

    return [path]; // ❌ Not real glyph strokes
  }
}
