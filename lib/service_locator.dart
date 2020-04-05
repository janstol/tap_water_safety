import 'package:get_it/get_it.dart';
import 'package:tap_water_safety/src/data/datasource/local/place_local_datasource_impl.dart';
import 'package:tap_water_safety/src/data/repository/place_repository_impl.dart';
import 'package:tap_water_safety/src/domain/repository/place_repository.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/animation_view_model.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';

/// The [GetIt] service locator instance.
final GetIt serviceLocator = GetIt.instance;

/// Sets up and creates all dependencies.
void setupServiceLocator() {
  serviceLocator.registerSingleton<PlaceRepository>(
    PlaceRepositoryImpl(PlaceLocalDataSourceImpl()),
  );

  serviceLocator.registerSingleton<PlaceViewModel>(
    PlaceViewModel(serviceLocator.get<PlaceRepository>()),
  );

  serviceLocator.registerSingleton<AnimationViewModel>(
    AnimationViewModel(),
  );
}
