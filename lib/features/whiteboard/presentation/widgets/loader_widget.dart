import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final String loaderText;

  const LoaderWidget(this.loaderText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(color: Colors.blueGrey, border: Border.all(width: 8), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircularProgressIndicator(),
          Text(loaderText, style: TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
