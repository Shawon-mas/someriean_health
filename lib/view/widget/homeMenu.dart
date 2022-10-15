import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/text_widget.dart';

import '../../global/properties.dart';
class HomeMenu extends StatelessWidget {
  final String menuTittle;
  final VoidCallback onPressed;
  final String imageMenu;
  const HomeMenu({
    Key? key, required this.menuTittle, required this.onPressed, required this.imageMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 130.h,
          width: 130.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Properties.primaryColor)),
          child: Column(
            children: [
              Container(
                height: 90.h,
                width: 130.h,
                color: Properties.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imageMenu,
                    height: 80.h,
                    width: 130.h,
                  ),
                ),
              ),
              Spacer(),
              TextWidget(
                value: menuTittle,
                size: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          )),
    );
  }
}