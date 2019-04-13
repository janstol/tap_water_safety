import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/scoped_model/place_model.dart';
import 'package:tap_water_safety/src/widgets/headline.dart';
import 'package:tap_water_safety/src/widgets/info_reveal.dart';
import 'package:tap_water_safety/src/widgets/page_content.dart';
import 'package:tap_water_safety/src/widgets/search_bar.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedPlace = PlaceModel.of(context, rebuildOnChange: true).place;

    final _screenSize = MediaQuery.of(context).size;

    // This check is because of release mode
    // see: https://github.com/flutter/flutter/issues/25827
    if (_screenSize == Size.zero) {
      return Container();
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _selectedPlace.waterSafety.colors.primaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageContent(
              headlines: [
                Headline(
                  text: _selectedPlace.waterSafety.firstHeadlineText,
                  color: _selectedPlace.waterSafety.colors.darkColor,
                  maxLines: 2,
                ),
                Headline(
                  text: _selectedPlace.waterSafety.secondHeadlineText,
                  color: Colors.white,
                  maxLines: _selectedPlace.waterSafety.maxLines,
                ),
              ],
            ),
            SearchBar(
              selectedPlace: _selectedPlace,
              screenSize: _screenSize,
            ),
            InfoReveal(),
          ],
        ),
      ),
    );
  }
}
