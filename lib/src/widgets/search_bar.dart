import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:tap_water_safety/src/model/place.dart';
import 'package:tap_water_safety/src/scoped_model/animation_model.dart';
import 'package:tap_water_safety/src/scoped_model/place_model.dart';
import 'package:tap_water_safety/src/theme.dart';

class SearchBar extends StatefulWidget {
  final Place selectedPlace;
  final Size screenSize;

  const SearchBar({Key key, this.selectedPlace, this.screenSize})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  _SearchBarSpringController _springBarController;

  double _expandPercent;
  double _minPercent;
  double _maxPercent;
  final double _barHeight = 65.0;
  bool _isOpen = false;

  var _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _minPercent = _barHeight / widget.screenSize.height;
    _maxPercent = 1.0 - _minPercent * 2;
    _expandPercent = _minPercent;

    _springBarController = _SearchBarSpringController(
      expandPercent: _minPercent,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _springBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _expandPercent = _springBarController.expandValue;
    if (_springBarController.state == SpringState.springing) {
      _expandPercent = _springBarController.springPercent;
    }

    // set info button visibility
    AnimationModel.of(context).setInfoButtonOpacity(1 -
        ((_expandPercent - _minPercent) / (_maxPercent - _minPercent))
            .clamp(0.0, 1.0));

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipPath(
        clipper: _SearchBarClipper(springBarController: _springBarController),
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
                        _SearchBarTop(
                          size: Size(constraints.maxWidth, _barHeight),
                          focusNode: _focusNode,
                          isOpen: _isOpen,
                          onBarTap: () => _handleOpenClose(),
                        ),
                        _SearchBarContent(
                          size: Size(
                            constraints.maxWidth,
                            (constraints.maxHeight - y - _barHeight)
                                .clamp(0.0, constraints.maxHeight),
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

  void open() {
    if (_springBarController.isIdle) {
      FocusScope.of(context).requestFocus(_focusNode);
      _springBarController.startMoving(_maxPercent);
      _isOpen = true;
    }
  }

  void close() {
    if (_springBarController.isIdle) {
      FocusScope.of(context).requestFocus(FocusNode());
      _springBarController.startMoving(_minPercent);
      _isOpen = false;
    }
  }

  void _selectItem(Place place) {
    if (_springBarController.isIdle) {
      PlaceModel.of(context).selectPlace(place);
      close();
    }
  }

  void _handleOpenClose() => _isOpen ? close() : open();
}

class _SearchBarTop extends StatelessWidget {
  final Size size;
  final bool isOpen;
  final FocusNode focusNode;
  final VoidCallback onBarTap;

  const _SearchBarTop(
      {Key key, this.size, this.onBarTap, this.focusNode, this.isOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedPlace = PlaceModel.of(context, rebuildOnChange: true).place;
    return GestureDetector(
      onTap: onBarTap,
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrey, width: 2.0),
          ),
        ),
        alignment: Alignment.center,
        child: ListTile(
          leading: Icon(Icons.search, size: 30.0),
          title: AnimatedCrossFade(
            duration: Duration(milliseconds: 250),
            crossFadeState:
                isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: TextField(
              style: TextStyle(fontSize: 21.0),
              focusNode: focusNode,
              onTap: onBarTap,
              onChanged: (text) => PlaceModel.of(context).searchPlaces(text),
            ),
            secondChild: _ItemText(
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

class _SearchBarContent extends StatelessWidget {
  final Size size;
  final Function(Place place) onItemTap;

  const _SearchBarContent({Key key, this.size, this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _placeModel = PlaceModel.of(context, rebuildOnChange: true);
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 4.0),
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return _SearchBarContentItem(
            place: _placeModel.places.elementAt(index),
            onTap: () => onItemTap(_placeModel.places.elementAt(index)),
          );
        },
        itemCount: _placeModel.places.length,
      ),
    );
  }
}

class _SearchBarContentItem extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const _SearchBarContentItem({Key key, this.place, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.history),
      title: _ItemText(city: place.city, country: place.country),
      trailing: Icon(
        Icons.brightness_1,
        color: place.waterSafety.colors.primaryColor,
      ),
      onTap: onTap,
    );
  }
}

class _ItemText extends StatelessWidget {
  final String city;
  final String country;

  const _ItemText({Key key, this.city, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 21.0, color: AppColors.grey),
        children: <TextSpan>[
          TextSpan(
            text: '$city, ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: '$country',
          ),
        ],
      ),
    );
  }
}

class _SearchBarClipper extends CustomClipper<Path> {
  final _SearchBarSpringController springBarController;

  double _expandPercent;

  _SearchBarClipper({this.springBarController}) {
    _expandPercent = springBarController.expandValue;
    if (springBarController.state == SpringState.springing) {
      _expandPercent = springBarController.springPercent;
    }
  }

  @override
  Path getClip(Size size) {
    if (springBarController.isIdle) {
      return _clipIdle(size);
    }
    return _clipMoving(size);
  }

  Path _clipIdle(Size size) {
    final baseY = (1.0 - _expandPercent) * size.height;
    return Path()
      ..addRect(Rect.fromLTRB(
        0.0,
        baseY,
        size.width,
        size.height,
      ));
  }

  Path _clipMoving(Size size) {
    Path compositePath = Path();

    final baseY = (1.0 - _expandPercent) * size.height;

    var leftPoint = Point(0.0, baseY);
    var rightPoint = Point(size.width, baseY);
    var centerPoint = Point(0.5 * size.width, baseY);

    final rect = Rect.fromLTRB(
      0.0,
      baseY,
      size.width,
      size.height,
    );
    compositePath.addRect(rect);

    final diff = springBarController.springEndPercent - _expandPercent;

    var offset = 30.0 * diff.abs();

    final curve = Path();

    if (springBarController.springStartPercent >
        springBarController.springEndPercent) {
      centerPoint += Point(0.0, offset);
      curve.moveTo(leftPoint.x, leftPoint.y - offset);
      curve.quadraticBezierTo(
        centerPoint.x,
        centerPoint.y,
        rightPoint.x,
        rightPoint.y - offset,
      );
      curve.lineTo(rightPoint.x, rightPoint.y);
      curve.lineTo(leftPoint.x, leftPoint.y);
      curve.close();
    } else {
      centerPoint += Point(0.0, -offset);
      curve.moveTo(leftPoint.x, leftPoint.y + offset);
      curve.quadraticBezierTo(
        centerPoint.x,
        centerPoint.y,
        rightPoint.x,
        rightPoint.y + offset,
      );
      curve.lineTo(rightPoint.x, rightPoint.y);
      curve.lineTo(leftPoint.x, leftPoint.y);
      curve.close();
    }

    compositePath.addPath(curve, Offset.zero);

    return compositePath;
  }

  @override
  bool shouldReclip(_SearchBarClipper oldClipper) =>
      oldClipper._expandPercent != springBarController._expandPercent;
}

class _SearchBarSpringController extends ChangeNotifier {
  final TickerProvider _vsync;
  final _springDescription = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 1.5,
    ratio: 0.75,
  );

  double _expandPercent;
  double _expandEndPercent;
  double _springStartPercent;
  double _springEndPercent;
  double _springPercent;
  SpringSimulation _springSimulation;
  Ticker _springTicker;
  double _springTime;

  var _state = SpringState.idle;

  _SearchBarSpringController({double expandPercent, vsync})
      : _vsync = vsync,
        _expandPercent = expandPercent;

  SpringState get state => _state;

  double get expandValue => _expandPercent;

  double get springPercent => _springPercent;

  double get springStartPercent => _springStartPercent;

  double get springEndPercent => _springEndPercent;

  bool get isIdle => _state == SpringState.idle;

  bool get isSpringing => _state == SpringState.springing;

  set expandValue(double value) {
    _expandPercent = value;
    notifyListeners();
  }

  set expandEndPercent(double value) {
    _expandEndPercent = value;
    notifyListeners();
  }

  void dispose() {
    if (_springTicker != null) {
      _springTicker.dispose();
    }
    super.dispose();
  }

  void startMoving(double expandEndPercent) {
    if (_springTicker != null) {
      _springTicker
        ..stop()
        ..dispose();
    }

    _expandEndPercent = expandEndPercent;
    _state = SpringState.springing;
    _springPercent = _expandPercent;
    _springStartPercent = _expandPercent;
    _springEndPercent = _expandEndPercent;

    _expandEndPercent = null;
    _expandPercent = _springEndPercent;

    _startSpringing();

    notifyListeners();
  }

  void _startSpringing() {
    _springSimulation = SpringSimulation(
      _springDescription,
      _springStartPercent,
      _springEndPercent,
      0.0,
    );

    _springTime = 0.0;
    _springTicker = _vsync.createTicker(_springTick)..start();
  }

  void _springTick(Duration deltaTime) {
    _springTime += deltaTime.inMilliseconds.toDouble() / 1000.0;
    _springPercent = _springSimulation.x(_springTime);

    if (_springSimulation.isDone(_springTime)) {
      _springTicker
        ..stop()
        ..dispose();
      _springTicker = null;
      _state = SpringState.idle;
    }

    notifyListeners();
  }
}

enum SpringState { idle, springing }
