import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/src/domain/entity/place.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/animation_view_model.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_clipper.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_content.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_header.dart';
import 'package:tap_water_safety/src/presentation/widget/search/search_sheet_spring_controller.dart';

class SearchSheet extends StatefulWidget {
  final Size screenSize;

  const SearchSheet({Key key, this.screenSize}) : super(key: key);

  @override
  _SearchSheetState createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet>
    with TickerProviderStateMixin {
  final double _barHeight = 65.0;
  final _focusNode = FocusNode();

  SearchSheetSpringController _springBarController;
  AnimationViewModel _animationViewModel;
  PlaceViewModel _placeViewModel;

  double _expandPercent;
  double _minPercent;
  double _maxPercent;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _minPercent = _barHeight / widget.screenSize.height;
    _maxPercent = 1.0 - _minPercent * 2;
    _expandPercent = _minPercent;

    _springBarController = SearchSheetSpringController(
      expandPercent: _minPercent,
      vsync: this,
    )..addListener(() => _update());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationViewModel ??= Provider.of<AnimationViewModel>(context);
    _placeViewModel ??= Provider.of<PlaceViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipPath(
        clipper: SearchSheetClipper(springController: _springBarController),
        child: Container(
          color: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              final y = height * (1.0 - _expandPercent);

              return Stack(
                children: <Widget>[
                  Positioned(
                    top: y,
                    left: 0.0,
                    child: Column(
                      children: <Widget>[
                        SearchSheetHeader(
                          size: Size(constraints.maxWidth, _barHeight),
                          focusNode: _focusNode,
                          isOpen: _isOpen,
                          onBarTap: () => _handleOpenClose(),
                        ),
                        SearchSheetContent(
                          size: Size(
                            constraints.maxWidth,
                            (constraints.maxHeight - y - _barHeight)
                                .clamp(0.0, constraints.maxHeight)
                                .toDouble(),
                          ),
                          onItemTap: (place) => _selectItem(place),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _update() {
    setState(() {
      _expandPercent = _springBarController.expandValue;
      if (_springBarController.state == SpringState.springing) {
        _expandPercent = _springBarController.springPercent;
      }

      _animationViewModel?.infoButtonOpacity = 1 -
          ((_expandPercent - _minPercent) / (_maxPercent - _minPercent))
              .clamp(0.0, 1.0)
              .toDouble();
    });
  }

  void _open() {
    if (_springBarController.isIdle) {
      FocusScope.of(context).requestFocus(_focusNode);
      _springBarController.startMoving(_maxPercent);
      _isOpen = true;
    }
  }

  void _close() {
    if (_springBarController.isIdle) {
      FocusScope.of(context).requestFocus(FocusNode());
      _springBarController.startMoving(_minPercent);
      _isOpen = false;
    }
  }

  void _selectItem(Place place) {
    if (_springBarController.isIdle) {
      _placeViewModel.place = place;
      _close();
    }
  }

  void _handleOpenClose() => _isOpen ? _close() : _open();
}
