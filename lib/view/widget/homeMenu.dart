import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:somerian_health/view/widget/text_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
              child: FittedBox(
                child: Column(
                  children: [
                    Image.asset(
                      imageMenu,
                      height: 80.h,
                      width: 140.h,
                    ),
                    SizedBox(height: 10.h,),
                    AutoSizeText(
                        menuTittle,
                       maxLines: 2,
                      style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Properties.primaryColor,

                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
 textColor: Properties.primaryColor,
                      value: menuTittle,
                      textAlign: TextAlign.center,
                      size: 16.sp,
                      fontWeight: FontWeight.w500,
                      edgeInsetsGeometry: EdgeInsets.zero,

 */
