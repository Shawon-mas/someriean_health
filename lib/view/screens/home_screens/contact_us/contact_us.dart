import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../../controller/personal_details_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';

class ContactUs extends StatelessWidget {
  final _controller = Get.put(PersonalDetailsController());
  final String title;
  ContactUs({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonToolbar(title: title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.shade300,
              height: 100.h,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Properties.colorTextBlue,
                        ),
                        TextWidget(
                          value: 'Call Center +971 2 575 4222',
                          isSelecteble: true,
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                          textColor: Properties.colorTextBlue,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Properties.colorTextBlue,
                        ),
                        TextWidget(
                          value: 'contact@somerianhealth.com',
                          isSelecteble: true,
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                          textColor: Properties.colorTextBlue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TextWidget(
              value: 'Please fill-up enquiry form',
              size: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: Properties.colorTextBlue,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                      title: 'Type Message Here',
                      textEditingController: _controller.typeMessageController,
                      enabled: true,
                    ),
                    SizedBox(
                      height: 200.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: 50,
          minWidth: double.maxFinite,
          color: Properties.primaryColor,
          child: Text(
            "Send Enquiry",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _controller.saveMessage(title, context);
          },
        ),
      ),
    );
  }

  Column customFields(
      {required String title,
      TextEditingController? textEditingController,
      bool? enabled,
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
