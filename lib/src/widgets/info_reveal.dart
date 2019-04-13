import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/scoped_model/animation_model.dart';
import 'package:tap_water_safety/src/scoped_model/place_model.dart';
import 'package:tap_water_safety/src/theme.dart';
import 'package:tap_water_safety/src/widgets/headline.dart';
import 'package:tap_water_safety/src/widgets/page_content.dart';

var _infoButtonKey = GlobalKey();

class InfoReveal extends StatefulWidget {
  @override
  _InfoRevealState createState() => _InfoRevealState();
}

class _InfoRevealState extends State<InfoReveal> with TickerProviderStateMixin {
  AnimationController _revealAnimationController;
  Animation<double> _revealAnimation;

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
  }

  @override
  void dispose() {
    _revealAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedPlace = PlaceModel.of(context).place;
    _opacity =
        AnimationModel.of(context, rebuildOnChange: true).infoButtonOpacity;

    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: <Widget>[
          ClipOval(
            clipper: _InfoRevealClipper(_revealPercent),
            child: _InfoContent(),
          ),
          _InfoButton(
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

class _InfoButton extends StatelessWidget {
  final ThemeColors colors;
  final double revealPercent;
  final VoidCallback onTap;

  const _InfoButton({Key key, this.colors, this.onTap, this.revealPercent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 90.0),
      child: AnimatedCrossFade(
        key: _infoButtonKey,
        duration: Duration(milliseconds: 250),
        crossFadeState: revealPercent < 0.49
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstCurve: Curves.easeOutCirc,
        secondCurve: Curves.easeInCirc,
        firstChild: FloatingActionButton(
          child: Text('i',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          mini: true,
          backgroundColor: colors.darkColor,
          elevation: 0.0,
          highlightElevation: 0.0,
          onPressed: onTap,
        ),
        secondChild: FloatingActionButton(
          child: Icon(
            Icons.clear,
            size: 30.0,
          ),
          mini: true,
          foregroundColor: Colors.white,
          backgroundColor: colors.primaryColor,
          elevation: 0.0,
          highlightElevation: 0.0,
          onPressed: onTap,
        ),
      ),
    );
  }
}

class _InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedPlace = PlaceModel.of(context, rebuildOnChange: true).place;

    return PageContent(
      backgroundColor: Colors.white,
      text: Text(
        _selectedPlace.info,
        style: TextStyle(
          fontSize: 22.0,
          color: AppColors.grey,
        ),
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

class _InfoRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  _InfoRevealClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {
    final RenderBox infoButton =
        _infoButtonKey.currentContext.findRenderObject();
    final center = infoButton.localToGlobal(
      Offset(infoButton.size.width / 2, infoButton.size.height / 2),
    );
    final distanceToBottomCorner = Offset(size.width, size.height).distance;
    final radius = distanceToBottomCorner * revealPercent;

    return Rect.fromLTWH(
      center.dx - radius,
      center.dy - radius,
      radius * 2,
      radius * 2,
    );
  }

  @override
  bool shouldReclip(_InfoRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}
