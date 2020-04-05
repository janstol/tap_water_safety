import 'package:tap_water_safety/src/domain/datasource_type.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/domain/result.dart';

abstract class PlaceRepository {
  /// Gets list of [Place]s from repository according to [query] search and
  /// [dataSourceType].
  ///
  /// Returns [Result.success] with list of [Place]s,
  /// or [Result.error] with [Exception] if there was an error.
  Future<Result<Exception, List<Place>>> getPlaces(
    String query,
    DataSourceType dataSourceType,
  );
}
