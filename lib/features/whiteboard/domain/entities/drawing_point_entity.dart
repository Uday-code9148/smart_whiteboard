import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';

class DrawingPointEntity<T> {
  final List<Offset> points;
  final Paint? paint;

  final RecognizedWrapper<T>? recDrawing;

  final FeatureCategory? selectedCategory;

  DrawingPointEntity({this.points = const [], this.paint, this.recDrawing, this.selectedCategory});

  DrawingPointEntity copyWith({List<Offset>? points, Paint? paint}) {
    return DrawingPointEntity(points: points ?? this.points, paint: paint ?? this.paint);
  }
}

class RecognizedWrapper<T> {
  final T recDrawing;

  RecognizedWrapper(this.recDrawing);
}
