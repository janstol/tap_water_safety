import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/constants.dart';
import 'package:tap_water_safety/src/theme.dart';

class InfoButton extends StatelessWidget {
  final ThemeColors colors;
  final double revealPercent;
  final VoidCallback onTap;

  const InfoButton({Key key, this.colors, this.onTap, this.revealPercent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 90.0),
      child: AnimatedCrossFade(
        key: infoButtonKey,
        duration: const Duration(milliseconds: 250),
        crossFadeState: revealPercent < 0.49
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstCurve: Curves.easeOutCirc,
        secondCurve: Curves.easeInCirc,
        firstChild: FloatingActionButton(
          mini: true,
          backgroundColor: colors.darkColor,
          elevation: 0.0,
          highlightElevation: 0.0,
          onPressed: onTap,
          child: const Text(
            'i',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        secondChild: FloatingActionButton(
          mini: true,
          foregroundColor: Colors.white,
          backgroundColor: colors.primaryColor,
          elevation: 0.0,
          highlightElevation: 0.0,
          onPressed: onTap,
          child: Icon(Icons.clear, size: 30.0),
        ),
      ),
    );
  }
}
