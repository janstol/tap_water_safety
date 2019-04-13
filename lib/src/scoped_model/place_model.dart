import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tap_water_safety/src/model/place.dart';

class PlaceModel extends Model {
  Place _place = Place.places.elementAt(2);
  List<Place> _places = Place.places;

  Place get place => _place;

  List<Place> get places => _places;

  void selectPlace(Place place) {
    _place = place;
    notifyListeners();
  }

  void searchPlaces(String name) {
    _places = Place.places
        .where((place) =>
            place.city.toLowerCase().contains(name.toLowerCase()) ||
            place.country.toLowerCase().contains(name.toLowerCase()))
        .toList();
    notifyListeners();
  }

  /// Wraps [ScopedModel.of] for this [Model].
  static PlaceModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<PlaceModel>(context, rebuildOnChange: rebuildOnChange);
}
