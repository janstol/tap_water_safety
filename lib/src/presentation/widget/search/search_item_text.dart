import 'package:flutter/material.dart';
import 'package:tap_water_safety/src/theme.dart';

class SearchItemText extends StatelessWidget {
  final String city;
  final String country;

  const SearchItemText({
    Key key,
    @required this.city,
    @required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 21.0, color: AppColors.grey),
        children: <TextSpan>[
          TextSpan(
            text: '$city, ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '$country'),
        ],
      ),
    );
  }
}
