import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

enum SpringState { idle, springing }

class SearchSheetSpringController extends ChangeNotifier {
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

  SearchSheetSpringController({double expandPercent, TickerProvider vsync})
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

  // ignore: avoid_setters_without_getters
  set expandEndPercent(double value) {
    _expandEndPercent = value;
    notifyListeners();
  }

  @override
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
