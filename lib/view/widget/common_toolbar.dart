import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/view/widget/text_widget.dart';

import '../../global/properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? voidCallback;
  const CommonToolbar({
    Key? key,
    required this.title,
    this.voidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Properties.primaryColor,
      centerTitle: true,
      title: TextWidget(
        textColor: Colors.white,
        value: title,
        size: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      leading: IconButton(
        onPressed: voidCallback == null
            ? () {
                //Navigator.pop(context);
                Get.back();
              }
            : voidCallback,
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
