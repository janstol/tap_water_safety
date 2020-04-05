import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/domain/entity/water_safety.dart';

final GlobalKey<State<StatefulWidget>> infoButtonKey = GlobalKey();

const List<Place> places = [
  Place(
    city: 'London',
    country: 'England',
    waterSafety: WaterSafety.safe(),
    info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Place(
    city: 'Berlin',
    country: 'Germany',
    waterSafety: WaterSafety.safe(),
    info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Place(
    city: 'Cairo',
    country: 'Egypt',
    waterSafety: WaterSafety.unsafe(),
    info:
        'Local tap water can be contaminated with Giardia Lamblia parasite and '
        'cause diarrhea.\n\nUse bottled or boiled water for consumption and '
        'brushing teeth.',
  ),
  Place(
    city: 'Lisbon',
    country: 'Portugal',
    waterSafety: WaterSafety.maybeSafe(),
    info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n'
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  Place(
    city: 'Vrbové',
    country: 'Slovakia',
    waterSafety: WaterSafety.maybeSafe(),
    info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n'
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
];
