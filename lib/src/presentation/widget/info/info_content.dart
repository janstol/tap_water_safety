import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';
import 'package:tap_water_safety/src/presentation/widget/headline.dart';
import 'package:tap_water_safety/src/presentation/widget/page_content.dart';
import 'package:tap_water_safety/src/theme.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedPlace = Provider.of<PlaceViewModel>(context).place;

    return PageContent(
      backgroundColor: Colors.white,
      text: Text(
        _selectedPlace.info,
        style: const TextStyle(fontSize: 22.0, color: AppColors.grey),
        textAlign: TextAlign.start,
      ),
      headlines: [
        Headline(
          text: _selectedPlace.waterSafety.secondHeadlineText,
          color: _selectedPlace.waterSafety.colors.primaryColor,
          maxLines: _selectedPlace.waterSafety.maxLines,
        ),
      ],
    );
  }
}
