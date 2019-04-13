import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Headline extends StatelessWidget {
  final String text;
  final Color color;
  final int maxLines;

  const Headline({Key key, this.text, this.color, this.maxLines = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 77.0,
          height: 0.85,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
