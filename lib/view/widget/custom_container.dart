import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/text_widget.dart';

class CustomContainer extends StatelessWidget {
  final String value;
  const CustomContainer({
    Key? key, required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      height: 50.h,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextWidget(
          value: value,
          size: 14.sp,
          fontWeight: FontWeight.w700,
          textColor: Colors.black,
        ),
      ),
    );
  }
}