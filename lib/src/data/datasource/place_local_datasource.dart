import 'package:tap_water_safety/src/domain/entity/place.dart';

/// Contract (interface) for [Place] remote data source.
///
/// Implement this if you want to create a [PlaceLocalDataSource].
abstract class PlaceLocalDataSource {
  /// Gets list of [Place] from local data source by search [query].
  Future<List<Place>> getPlaces(String query);
}
