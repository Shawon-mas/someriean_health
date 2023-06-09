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
import '../../../utilites/api_services.dart';
import '../../../utilites/shared_prefs.dart';
import '../../widget/primary_toolbar.dart';
import '../../widget/text_widget.dart';
import '../home_screens/contact_us/contact_us.dart';
import '../menu_screen/about_application.dart';
import '../menu_screen/about_somerian.dart';
import '../menu_screen/language.dart';
import '../menu_screen/my_profile/my_profile.dart';

class MenuScreen extends StatelessWidget {
  final _controller = Get.put(MenusController());
  MenuScreen({Key? key}) : super(key: key);
  final List<String> menuList = [
    'My Profile',
    'Feedback',

    'Need Help',
    'About Application',
    'About Somerian Health',
    'Language Preferences',

  ];
  List<IconData> _iconTypes = [
    FluentSystemIcons.ic_fluent_person_regular,
    FluentSystemIcons.ic_fluent_person_feedback_regular,

    FluentSystemIcons.ic_fluent_chat_help_regular,
    FluentSystemIcons.ic_fluent_info_regular,
    Icons.dashboard,
    FluentSystemIcons.ic_fluent_local_language_regular,

  ];
  @override
  Widget build(BuildContext context) {
    _controller.getUserData();
    return Scaffold(
      appBar: PrimaryToolbar(
        appbarIcons: [
          TextButton(
            onPressed: () async{
              await SharedPrefs().prefsClear();
              // FirebaseAuth.instance.signOut();
              Get.offAllNamed(login);
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
              color: Colors.grey.shade300,
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
                              '${ApiServices.IMAGE_BASE_URL}/${_controller.imagePath.value}',
                              //_controller.imagePath.value
                            ),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              'https://cutt.ly/yVi8MKf',
                            ),
                          ),
                    TextWidget(
                      edgeInsetsGeometry: EdgeInsets.zero,
                      value: _controller.name.value,
                      textColor: Properties.colorTextBlue,
                      size: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    TextWidget(
                      edgeInsetsGeometry: EdgeInsets.zero,
                      value: "MRN-${_controller.emarites.value}",
                      textColor: Properties.colorTextBlue,
                      size: 20.sp,
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
                        //Get.off(() => MyProfileScreen());
                        Get.to(() => MyProfileScreen());
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfileScreen())); */
                        // infoSnackBar(context,'Coming soon');
                      }
                      if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUs(
                                      title: menuList[index],
                                    )));
                      }

                      if (index == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUs(
                                      title: menuList[index],
                                    )));
                      }
                      if (index == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutApplication()));
                      }
                      if (index == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutSomerian()));
                      }
                      if (index == 5) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Language()));
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
