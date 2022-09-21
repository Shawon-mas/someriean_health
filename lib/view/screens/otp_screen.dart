import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:somerian_health/controller/login_controller.dart';

import '../../global/properties.dart';
import '../widget/common_toolbar.dart';
import '../widget/custom_button.dart';
import '../widget/text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatelessWidget {
  final LoginController controller;
  final String verificationId;

  const OtpScreen({Key? key, required this.controller, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CommonToolbar(title: "Otp Verification"),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                textColor: Properties.colorTextBlue,
                value: "Verification Code",
                size: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                textColor: Properties.colorTextBlue,
                value: "Please enter the verification code sent",
                size: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              TextWidget(
                textColor: Properties.colorTextBlue,
                value: "to mobile number",
                size: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                controller: controller.otpController,
                showCursor: true,
                onCompleted: (pin) => controller.registerUser(pin, verificationId, context),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return CustomButton(
                  textColor: Colors.white,
                  value: "Verify phone number",
                  isLoading: controller.isVerifyingOtp.value,
                  buttonColor: Properties.primaryColor,
                  onPressed: () {
                    controller.registerUser(controller.otpController.text, verificationId, context);
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    textColor: Properties.colorTextBlue,
                    value: "Didn't receive an OTP ?",
                    size: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextWidget(
                    textColor: Properties.colorTextBlue,
                    onPressed: () {},
                    value: "Resend",
                    size: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
