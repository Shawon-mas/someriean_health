import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color? textColor;
  final String value;
  final VoidCallback? onPressed;
  const CustomButton({
    Key? key, required this.buttonColor, this.onPressed, required this.value,  this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: double.infinity,
        height: 50,
        color: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11)
        ),
        child: Text(value, style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: textColor,
        ),
        ),
        onPressed: onPressed

    );
  }
}