import 'package:flutter/widgets.dart';

class AnimationViewModel extends ChangeNotifier {
  double _infoButtonOpacity = 1.0;

  double get infoButtonOpacity => _infoButtonOpacity;

  set infoButtonOpacity(double value) {
    _infoButtonOpacity = value;
    notifyListeners();
  }

  void setInfoButtonOpacity(double opacity) {
    _infoButtonOpacity = opacity;
    notifyListeners();
  }
}
