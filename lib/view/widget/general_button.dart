import 'package:flutter/material.dart';

import '../../global/properties.dart';

class AppointmentButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String value;

  final VoidCallback onPressed;

  const AppointmentButton({
    Key? key,
    this.buttonColor = Properties.primaryColor,
    required this.onPressed,
    required this.value,
    this.textColor = Colors.white,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 40,
      color: buttonColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: textColor,
              ),
            ),
      onPressed: onPressed,
    );
  }
}
