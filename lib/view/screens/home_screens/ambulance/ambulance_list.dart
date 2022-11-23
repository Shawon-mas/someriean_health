import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class Ambulance_List extends StatelessWidget {
  const Ambulance_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: "Ambulance"),
      body: Column(
        children: [
          TextWidget(
            value: 'Available Ambulance',
            textColor: Properties.colorTextBlue,
            size: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
