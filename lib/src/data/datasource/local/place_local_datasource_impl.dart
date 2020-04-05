import 'package:tap_water_safety/src/constants.dart';
import 'package:tap_water_safety/src/data/datasource/place_local_datasource.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';

/// Implementation of [PlaceLocalDataSource].
class PlaceLocalDataSourceImpl implements PlaceLocalDataSource {
  @override
  Future<List<Place>> getPlaces(String query) {
    final _places = places.where((place) {
      return place.city.toLowerCase().contains(query.toLowerCase()) ||
          place.country.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Future.value(_places);
  }
}
