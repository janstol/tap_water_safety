import 'package:tap_water_safety/src/theme.dart';

enum Safety { safe, unsafe, maybeSafe }

class WaterSafety {
  final Safety safety;
  final ThemeColors colors;
  final String firstHeadlineText;
  final String secondHeadlineText;
  final int maxLines;

  const WaterSafety.safe()
      : safety = Safety.safe,
        colors = AppTheme.safeColors,
        firstHeadlineText = 'Tap water is',
        secondHeadlineText = 'safe to drink.',
        maxLines = 2;

  const WaterSafety.unsafe()
      : safety = Safety.unsafe,
        colors = AppTheme.unsafeColors,
        firstHeadlineText = 'Tap water is',
        secondHeadlineText = 'unsafe to drink.',
        maxLines = 2;

  const WaterSafety.maybeSafe()
      : safety = Safety.maybeSafe,
        colors = AppTheme.maybeSafeColors,
        firstHeadlineText = 'Tap water',
        secondHeadlineText = 'may be safe to drink.',
        maxLines = 3;
}
