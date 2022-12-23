import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somerian_health/controller/personal_details_controller.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'dart:io';
import 'package:somerian_health/global/properties.dart';

import '../../../widget/text_widget.dart';

class PersonalDetailsScreen extends StatelessWidget {
  final _controller = Get.put(PersonalDetailsController());
  PersonalDetailsScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Obx(
                              () => _controller.isImageUploading.value == true
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.grey.shade400,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : _controller.imagePath.value != ""
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            _controller.imagePath.value,
                                          ),
                                          radius: 60,
                                        )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                            'https://cutt.ly/yVi8MKf',
                                          ),
                                        ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: Obx(
                                () => InkWell(
                                  onTap:
                                      _controller.isImageUploading.value == true
                                          ? () {
                                              infoSnackBar(context,
                                                  "Image is uploading, Please wait");
                                            }
                                          : () {
                                              _controller.pickImage();
                                            },
                                  child: buildEditIcon(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _controller.isEditable.value =
                          !_controller.isEditable.value;
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Properties.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: customFields(
                            title: 'First Name',
                            textEditingController:
                                _controller.firstNameController,
                            enabled: _controller.isEditable.value,
                          ),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        Expanded(
                          child: customFields(
                            title: 'Last Name',
                            textEditingController:
                                _controller.lastNameController,
                            enabled: _controller.isEditable.value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Date of Birth',
                      textEditingController: _controller.dobController,
                      enabled: _controller.isEditable.value,
                      trailingIcon: IconButton(
                        onPressed: () {
                          _controller.selectDate(context);
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Mobile Number',
                      textEditingController: _controller.mobileController,
                      enabled: false,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Email',
                      textEditingController: _controller.emailController,
                      enabled: _controller.isEditable.value,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Gender',
                      textEditingController: _controller.genderController,
                      enabled: _controller.isEditable.value,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Nationality',
                      textEditingController: _controller.nationalityController,
                      enabled: _controller.isEditable.value,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    customFields(
                      title: 'Emirates ID',
                      textEditingController: _controller.emiratesIdController,
                      enabled: _controller.isEditable.value,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Visibility(
                      visible: _controller.isEditable.value,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          height: 50,
                          minWidth: double.maxFinite,
                          color: Properties.primaryColor,
                          child: Text(
                            "Update profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _controller.updateInfo(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditIcon() {
    return ClipOval(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(2),
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(5),
            color: Properties.colorTextBlue,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Column customFields(
      {required String title,
      required TextEditingController textEditingController,
      required bool enabled,
      Widget? trailingIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          value: title,
          textColor: Properties.colorTextBlue,
          size: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(
          height: 7.h,
        ),
        TextField(
          enabled: enabled,
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: trailingIcon,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Color.fromRGBO(
                0,
                48,
                73,
                0.5,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(
              5.0,
              5.0,
              5.0,
              5.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
