import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';

class DrawingPointEntity<T> {
  final List<Offset> points;
  final Paint? paint;

  final RecognizedWrapper<T>? recDrawing;

  final FeatureCategory? selectedCategory;
  final Rect? position;

  DrawingPointEntity({this.points = const [], this.paint, this.recDrawing, this.selectedCategory, this.position});

  DrawingPointEntity copyWith({
    List<Offset>? points,
    Paint? paint,
    RecognizedWrapper<T>? recDrawing,
    FeatureCategory? selectedCategory,
    Rect? position,
  }) {
    return DrawingPointEntity(
      points: points ?? this.points,
      paint: paint ?? this.paint,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      recDrawing: recDrawing ?? this.recDrawing,
      position: position ?? this.position,
    );
  }
}

class RecognizedWrapper<T> {
  final T recDrawing;

  RecognizedWrapper(this.recDrawing);
}
