import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/presentation/widget/headline.dart';

class PageContent extends StatelessWidget {
  final Text text;
  final List<Headline> headlines;
  final Color backgroundColor;

  const PageContent({
    Key key,
    this.headlines,
    this.text,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[];
    if (text != null) {
      content.add(text);
    }

    if (headlines.isNotEmpty) {
      content.add(
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: headlines,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(60.0, 180.0, 60.0, 125.0),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content,
      ),
    );
  }
}
