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
          height: 115.h,
          width: 100.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Properties.primaryColor)),
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: 100.h,
                color: Properties.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imageMenu,
                    height: 80,
                    width: 100,
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