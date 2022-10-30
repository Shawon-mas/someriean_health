import 'package:flutter/material.dart';
import 'package:somerian_health/global/properties.dart';
import '../constants.dart';

class IconContent extends StatelessWidget {
  IconContent(
      {required this.icon, required this.label, required this.isSelected});

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
          color: !isSelected ? Properties.primaryColor : Colors.white,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: isSelected ? kLabelTextStyleWhite : kLabelTextStyleGender,
        )
      ],
    );
  }
}
