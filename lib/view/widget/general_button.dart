import 'package:flutter/material.dart';

import '../../global/properties.dart';

class AppointmentButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String value;
  final bool isLoading;
  final VoidCallback onPressed;

  const AppointmentButton({
    Key? key,
    this.buttonColor = Properties.primaryColor,
    required this.onPressed,
    required this.value,
    this.textColor = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 40,
      color: buttonColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: !isLoading
          ? Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: textColor,
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
      onPressed: onPressed,
    );
  }
}
