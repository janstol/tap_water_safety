import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_water_safety/src/constants.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/animation_view_model.dart';
import 'package:tap_water_safety/src/presentation/viewmodel/place_view_model.dart';
import 'package:tap_water_safety/src/presentation/widget/info/info_button.dart';
import 'package:tap_water_safety/src/presentation/widget/info/info_content.dart';

class InfoReveal extends StatefulWidget {
  @override
  _InfoRevealState createState() => _InfoRevealState();
}

class _InfoRevealState extends State<InfoReveal> with TickerProviderStateMixin {
  AnimationController _revealAnimationController;
  Animation<double> _revealAnimation;

  Offset _infoButtonPosition = Offset.zero;
  double _revealPercent = 0.0;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _revealAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _revealAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(_revealAnimationController)
          ..addListener(
              () => setState(() => _revealPercent = _revealAnimation.value));

    WidgetsBinding.instance.addPostFrameCallback((_) => _getInfoButtonPos());
  }

  void _getInfoButtonPos() {
    final RenderBox box =
        infoButtonKey.currentContext.findRenderObject() as RenderBox;
    final offset = Offset(box.size.width / 2, box.size.height / 2);
    _infoButtonPosition = box.localToGlobal(offset);
  }

  @override
  void dispose() {
    _revealAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedPlace = Provider.of<PlaceViewModel>(context).place;
    _opacity = Provider.of<AnimationViewModel>(context).infoButtonOpacity;

    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: <Widget>[
          ClipOval(
            clipper: _InfoRevealClipper(_infoButtonPosition, _revealPercent),
            child: InfoContent(),
          ),
          InfoButton(
            revealPercent: _revealPercent,
            colors: _selectedPlace.waterSafety.colors,
            onTap: () => _onTap(),
          ),
        ],
      ),
    );
  }

  void _onTap() {
    if (!_revealAnimationController.isAnimating && _opacity == 1.0) {
      if (_revealAnimation.isCompleted) {
        _revealAnimationController.reverse();
      }
      if (_revealAnimation.isDismissed) {
        _revealAnimationController.forward();
      }
    }
  }
}

class _InfoRevealClipper extends CustomClipper<Rect> {
  final Offset position;
  final double revealPercent;

  _InfoRevealClipper(this.position, this.revealPercent);

  @override
  Rect getClip(Size size) {
    final distanceToBottomCorner = Offset(size.width, size.height).distance;
    final radius = distanceToBottomCorner * revealPercent;

    return Rect.fromLTWH(
      position.dx - radius,
      position.dy - radius,
      radius * 2,
      radius * 2,
    );
  }

  @override
  bool shouldReclip(_InfoRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}
