import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ShapesEnum {
  line(Icon(Icons.calculate_rounded, color: Colors.yellow)),
  rectangle(Icon(Icons.calculate_rounded, color: Colors.brown)),
  square(Icon(Icons.calculate_rounded, color: Colors.black12)),
  circle(Icon(Icons.calculate_rounded, color: Colors.orange)),
  ellipse(Icon(Icons.calculate_rounded, color: Colors.red)),
  triangle(Icon(Icons.calculate_rounded, color: Colors.greenAccent)),
  arrow(Icon(Icons.calculate_rounded, color: Colors.blue));

  final Icon icon;

  const ShapesEnum(this.icon);
}
