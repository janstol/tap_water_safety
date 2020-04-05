import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_spring_controller.dart';

class SearchSheetClipper extends CustomClipper<Path> {
  final SearchSheetSpringController springController;

  double _expandPercent;

  SearchSheetClipper({this.springController}) {
    _expandPercent = springController.expandValue;
    if (springController.state == SpringState.springing) {
      _expandPercent = springController.springPercent;
    }
  }

  @override
  Path getClip(Size size) {
    if (springController.isIdle) {
      return _clipIdle(size);
    }
    return _clipMoving(size);
  }

  Path _clipIdle(Size size) {
    final baseY = (1.0 - _expandPercent) * size.height;
    return Path()..addRect(Rect.fromLTRB(0.0, baseY, size.width, size.height));
  }

  Path _clipMoving(Size size) {
    final compositePath = Path();

    final baseY = (1.0 - _expandPercent) * size.height;

    final leftPoint = Point(0.0, baseY);
    final rightPoint = Point(size.width, baseY);
    var centerPoint = Point(0.5 * size.width, baseY);

    final rect = Rect.fromLTRB(0.0, baseY, size.width, size.height);
    compositePath.addRect(rect);

    final diff = springController.springEndPercent - _expandPercent;

    final offset = 30.0 * diff.abs();

    final curve = Path();

    if (springController.springStartPercent >
        springController.springEndPercent) {
      centerPoint += Point(0.0, offset);
      curve.moveTo(leftPoint.x, leftPoint.y - offset);
      curve.quadraticBezierTo(
        centerPoint.x,
        centerPoint.y,
        rightPoint.x,
        rightPoint.y - offset,
      );
      curve.lineTo(rightPoint.x, rightPoint.y);
      curve.lineTo(leftPoint.x, leftPoint.y);
      curve.close();
    } else {
      centerPoint += Point(0.0, -offset);
      curve.moveTo(leftPoint.x, leftPoint.y + offset);
      curve.quadraticBezierTo(
        centerPoint.x,
        centerPoint.y,
        rightPoint.x,
        rightPoint.y + offset,
      );
      curve.lineTo(rightPoint.x, rightPoint.y);
      curve.lineTo(leftPoint.x, leftPoint.y);
      curve.close();
    }

    compositePath.addPath(curve, Offset.zero);

    return compositePath;
  }

  @override
  bool shouldReclip(SearchSheetClipper oldClipper) =>
      oldClipper._expandPercent != _expandPercent;
}
