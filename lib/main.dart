import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_water_safety/src/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}
