import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/text_widget.dart';

import '../../global/properties.dart';
enum LanguageType{English,Arabic}
class MyRadioButton extends StatelessWidget {
 final String title;
 final LanguageType value;
 final LanguageType? languageType;
 final Function(LanguageType?)? onChanged;
  const MyRadioButton({Key? key,
    required this.title,
    required this.value,
    this.languageType,
    this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<LanguageType>(
      title:  TextWidget(
        edgeInsetsGeometry: EdgeInsets.zero,
        value: title,
        textColor: Properties.colorTextBlue,
        size: 20.sp,
        fontWeight: FontWeight.w700,
      ),
      value: value,
      groupValue: languageType,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      dense: true,

    );
  }
}
