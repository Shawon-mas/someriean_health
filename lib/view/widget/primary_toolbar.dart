import 'package:flutter/material.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrimaryToolbar extends StatelessWidget implements PreferredSizeWidget{
  const PrimaryToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Properties.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0.h);
}