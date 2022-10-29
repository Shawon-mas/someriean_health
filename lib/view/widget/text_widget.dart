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
  final EdgeInsetsGeometry edgeInsetsGeometry;

  const TextWidget({
    Key? key,
    required this.value,
    this.textColor,
    this.onPressed,
    this.edgeInsetsGeometry = const EdgeInsets.all(10.0),
    required this.size,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsGeometry,
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
