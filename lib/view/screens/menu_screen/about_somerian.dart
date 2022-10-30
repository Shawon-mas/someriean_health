import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/properties.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/text_widget.dart';
class AboutSomerian extends StatelessWidget {
  const AboutSomerian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: "About Somerian Health"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Image.asset(
                "assets/images/main_logo.png",
              ),
            ),
          ),
          TextWidget(
            value: 'About Somerian Health',
            size: 16.sp,
            fontWeight: FontWeight.bold,
            textColor: Properties.colorTextBlue,
          ),
          TextWidget(
            value: 'Support: contact@somerianhealth.com',
            size: 16.sp,
            fontWeight: FontWeight.bold,
            textColor: Properties.colorTextBlue,
          ),
        ],
      ),
    );
  }
}
