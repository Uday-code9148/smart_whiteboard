import 'package:flutter/material.dart';

class DrawingPointEntity {
  final Offset? points;
  final Paint? paint;

  DrawingPointEntity({this.points, this.paint});

  DrawingPointEntity copyWith({Offset? points, Paint? paint}) {
    return DrawingPointEntity(points: points ?? this.points, paint: paint ?? this.paint);
  }
}
