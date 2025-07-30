import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ShapesEnum {
  line(Icon(Icons.line_axis, color: Colors.yellow)),
  rectangle(Icon(Icons.rectangle_outlined, color: Colors.brown)),
  square(Icon(Icons.square_rounded, color: Colors.black12)),
  circle(Icon(Icons.circle_outlined, color: Colors.orange)),
  ellipse(Icon(Icons.hexagon, color: Colors.red)),
  triangle(Icon(Icons.terrain_outlined, color: Colors.greenAccent)),
  arrow(Icon(Icons.arrow_back, color: Colors.blue));

  final Icon icon;

  const ShapesEnum(this.icon);
}
