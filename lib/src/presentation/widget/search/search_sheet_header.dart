import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_item_text.dart';
import 'package:tap_water_safety/src/theme.dart';

class SearchSheetHeader extends StatelessWidget {
  final Size size;
  final bool isOpen;
  final FocusNode focusNode;
  final VoidCallback onBarTap;

  const SearchSheetHeader({
    Key key,
    this.size,
    this.onBarTap,
    this.focusNode,
    this.isOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _placeViewModel = Provider.of<PlaceViewModel>(context);
    final _selectedPlace = _placeViewModel.place;

    return GestureDetector(
      onTap: onBarTap,
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(color: AppColors.lightGrey, width: 2.0),
          ),
        ),
        alignment: Alignment.center,
        child: ListTile(
          leading: Icon(Icons.search, size: 30.0),
          title: AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState:
                isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: TextField(
              style: const TextStyle(fontSize: 21.0),
              focusNode: focusNode,
              onTap: onBarTap,
              onChanged: (text) => _placeViewModel.searchPlaces(text),
            ),
            secondChild: SearchItemText(
              city: _selectedPlace.city,
              country: _selectedPlace.country,
            ),
          ),
          trailing: Icon(Icons.close, size: 30.0),
        ),
      ),
    );
  }
}
