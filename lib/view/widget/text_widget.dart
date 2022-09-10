import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextWidget extends StatelessWidget {
  final String value;
  final Color? textColor;
  final double size;
  final VoidCallback? onPressed;
  const TextWidget({
    Key? key, required this.value, this.textColor, this.onPressed, required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(value, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size,
          color: textColor
        ),
        ),
      ),
    );
  }
}