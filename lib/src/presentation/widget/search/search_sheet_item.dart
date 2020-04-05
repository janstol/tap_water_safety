import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_item_text.dart';

class SearchSheetItem extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const SearchSheetItem({Key key, this.place, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.history),
      title: SearchItemText(city: place.city, country: place.country),
      trailing: Icon(
        Icons.brightness_1,
        color: place.waterSafety.colors.primaryColor,
      ),
      onTap: onTap,
    );
  }
}
