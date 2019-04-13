import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class AnimationModel extends Model {
  double _infoButtonOpacity = 1.0;

  double get infoButtonOpacity => _infoButtonOpacity;

  void setInfoButtonOpacity(double opacity) {
    _infoButtonOpacity = opacity;
    notifyListeners();
  }

  /// Wraps [ScopedModel.of] for this [Model].
  static AnimationModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<AnimationModel>(context, rebuildOnChange: rebuildOnChange);
}
