import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tap_water_safety/src/main_page.dart';
import 'package:tap_water_safety/src/scoped_model/animation_model.dart';
import 'package:tap_water_safety/src/scoped_model/place_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap water safety',
      home: ScopedModel<AnimationModel>(
        model: AnimationModel(),
        child: ScopedModel<PlaceModel>(
          model: PlaceModel(),
          child: MainPage(),
        ),
      ),
    );
  }
}
