import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global/properties.dart';

class TextWidget extends StatelessWidget {
  final String value;
  final Color? textColor;
  final double size;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;

  const TextWidget({
    Key? key,
    required this.value,
    this.textColor,
    this.onPressed,
    required this.size,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          value,
          style: GoogleFonts.lato(
            fontWeight: fontWeight,
            fontSize: size,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
