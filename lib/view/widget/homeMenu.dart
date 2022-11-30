import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/text_widget.dart';

import '../../global/properties.dart';

class HomeMenu extends StatelessWidget {
  final String menuTittle;
  final VoidCallback onPressed;
  final String imageMenu;
  const HomeMenu({
    Key? key,
    required this.menuTittle,
    required this.onPressed,
    required this.imageMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Image.asset(
                      imageMenu,
                      height: 80.h,
                      width: 140.h,
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Expanded(
                    flex: 4,
                    child: TextWidget(
                      textColor: Properties.primaryColor,
                      value: menuTittle,
                      textAlign: TextAlign.center,
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
