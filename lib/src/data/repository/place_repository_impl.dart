import 'package:tap_water_safety/src/data/datasource/place_local_datasource.dart';
import 'package:tap_water_safety/src/domain/datasource_type.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/domain/repository/place_repository.dart';
import 'package:tap_water_safety/src/domain/result.dart';

/// Implementation of [PlaceRepository].
class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceLocalDataSource _placeLocalDataSource;

  PlaceRepositoryImpl(this._placeLocalDataSource);

  @override
  Future<Result<Exception, List<Place>>> getPlaces(
    String query,
    DataSourceType dataSourceType,
  ) async {
    try {
      if (dataSourceType == DataSourceType.remote) {
        throw UnimplementedError();
      } else {
        return Result.success(await _placeLocalDataSource.getPlaces(query));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
