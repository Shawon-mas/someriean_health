import 'package:flutter/material.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryToolbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? appbarIcons;
  const PrimaryToolbar({
    Key? key, this.appbarIcons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Properties.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
        child: Image.asset(
          'assets/images/splash.png',
       /*   height: 70.h,
          width: 50.w,*/
        ),
      ),
      actions:appbarIcons,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
