import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/domain/datasource_type.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/domain/repository/place_repository.dart';

class PlaceViewModel extends ChangeNotifier {
  final PlaceRepository _placeRepository;

  Place _place;
  List<Place> _places = [];

  PlaceViewModel(this._placeRepository) {
    _init();
  }

  Place get place => _place;

  set place(Place value) {
    _place = value;
    notifyListeners();
  }

  List<Place> get places => _places;

  Future<void> searchPlaces(String name) async {
    _places = [];

    final result = await _placeRepository.getPlaces(name, DataSourceType.local);
    if (result.hasValue) {
      _places = result.value;
    }

    notifyListeners();
  }

  Future<void> _init() async {
    _places = [];
    _place = const Place.empty();

    final result = await _placeRepository.getPlaces('', DataSourceType.local);
    if (result.hasValue) {
      _places = result.value;
      place = places.first;
    }

    notifyListeners();
  }
}
