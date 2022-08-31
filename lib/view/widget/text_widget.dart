import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextWidget extends StatelessWidget {
  final String value;
  const TextWidget({
    Key? key, required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(value, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp
      ),
      ),
    );
  }
}