import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureCategory {
  final String? name;
  final List<FeatureCategory> items;
  final Icon icon;
  final VoidCallback? onTap;

  FeatureCategory({this.name = "Feature Category", this.icon = const Icon(Icons.pending_actions), this.items = const [], this.onTap});
}
