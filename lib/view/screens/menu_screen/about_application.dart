import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/properties.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/text_widget.dart';
class AboutApplication extends StatelessWidget {
  const AboutApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: "About Application"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                  "assets/images/main_logo.png",
              ),
            ),
            TextWidget(
              value: 'Version 1.0',
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
      ),
    );
  }
}
