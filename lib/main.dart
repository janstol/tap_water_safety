import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_water_safety/service_locator.dart';
import 'package:tap_water_safety/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupServiceLocator();

  runApp(App());
}
