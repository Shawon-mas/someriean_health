import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:somerian_health/controller/menu_controller.dart';

import '../../../global/global_constants.dart';
import '../../../global/properties.dart';
import '../../../routes/routes.dart';
import '../../widget/primary_toolbar.dart';
import '../../widget/text_widget.dart';
import '../menu_screen/my_profile/my_profile.dart';

class MenuScreen extends StatelessWidget {
  final _controller = Get.put(MenuController());
  MenuScreen({Key? key}) : super(key: key);
  final List<String> menuList = [
    'My Profile',
    'Feedback',
    'News and Media',
    'Need Help',
    'About Application',
    'Language Preferences',
    'Settings',
  ];
  List<IconData> _iconTypes = [
    FluentSystemIcons.ic_fluent_person_regular,
    FluentSystemIcons.ic_fluent_person_feedback_regular,
    FluentSystemIcons.ic_fluent_news_regular,
    FluentSystemIcons.ic_fluent_chat_help_regular,
    FluentSystemIcons.ic_fluent_info_regular,
    FluentSystemIcons.ic_fluent_local_language_regular,
    FluentSystemIcons.ic_fluent_settings_regular,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryToolbar(
        appbarIcons: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed(splash);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              height: 220.h,
              width: double.maxFinite,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _controller.imagePath.value != ""
                        ? CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              _controller.imagePath.value,
                            ),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              'https://cutt.ly/yVi8MKf',
                            ),
                          ),
                    TextWidget(
                      value: _controller.name.value,
                      textColor: Colors.white,
                      size: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
                itemCount: menuList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Get.off(() => MyProfileScreen());
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfileScreen())); */
                      }
                    },
                    child: ListTile(
                      title: TextWidget(
                        value: menuList[index],
                        size: 14.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Properties.fontColor,
                      ),
                      leading:
                          Icon(_iconTypes[index], color: Properties.fontColor),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Properties.fontColor,
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
//1011044052505