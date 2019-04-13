import 'package:tap_water_safety/src/model/water_safety.dart';

class Place {
  final String city;
  final String country;
  final WaterSafety waterSafety;
  final String info;

  Place({this.city, this.country, this.waterSafety, this.info});

  static List<Place> get places => [
        Place(
          city: 'London',
          country: 'England',
          waterSafety: WaterSafety.safe(),
          info:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Place(
          city: 'Berlin',
          country: 'Germany',
          waterSafety: WaterSafety.safe(),
          info:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Place(
          city: 'Cairo',
          country: 'Egypt',
          waterSafety: WaterSafety.unsafe(),
          info:
              'Local tap water can be contaminated with Giardia Lamblia parasite and cause diarrhea.\n\nUse bottled or boiled water for consumption and brushing teeth.',
        ),
        Place(
          city: 'Lisbon',
          country: 'Portugal',
          waterSafety: WaterSafety.maybeSafe(),
          info:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nSed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
        Place(
          city: 'Vrbové',
          country: 'Slovakia',
          waterSafety: WaterSafety.maybeSafe(),
          info:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nSed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      ];
}
