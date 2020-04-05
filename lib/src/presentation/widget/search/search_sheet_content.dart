import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_item.dart';

class SearchSheetContent extends StatelessWidget {
  final Size size;
  final Function(Place place) onItemTap;

  const SearchSheetContent({
    Key key,
    this.size,
    this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _placeViewModel = Provider.of<PlaceViewModel>(context);

    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 4.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _placeViewModel.places.length,
        itemBuilder: (context, index) {
          final place = _placeViewModel.places.elementAt(index);
          return SearchSheetItem(
            place: place,
            onTap: () => onItemTap(place),
          );
        },
      ),
    );
  }
}
