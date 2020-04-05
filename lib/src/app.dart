import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/service_locator.dart';
import 'package:tap_water_safety/src/presentation/page/main_page.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/animation_view_model.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap water safety',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: serviceLocator.get<PlaceViewModel>(),
          ),
          ChangeNotifierProvider.value(
            value: serviceLocator.get<AnimationViewModel>(),
          ),
        ],
        child: MainPage(),
      ),
    );
  }
}
