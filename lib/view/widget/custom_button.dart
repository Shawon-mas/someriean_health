import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color? textColor;
  final String value;
  final bool isLoading;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.buttonColor,
    this.onPressed,
    required this.value,
    this.textColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: buttonColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
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
