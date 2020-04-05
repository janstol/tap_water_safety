import 'package:tap_water_safety/src/domain/entity/water_safety.dart';

class Place {
  final String city;
  final String country;
  final WaterSafety waterSafety;
  final String info;

  const Place({this.city, this.country, this.waterSafety, this.info});

  const Place.empty()
      : city = 'n/a',
        country = 'n/a',
        waterSafety = const WaterSafety.unsafe(),
        info = 'n/a';

  @override
  int get hashCode =>
      city.hashCode ^ country.hashCode ^ waterSafety.hashCode ^ info.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Place && city == other.city && country == other.country;
  }

  @override
  String toString() => 'Place($city)';
}
