import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../global/properties.dart';
import '../widget/common_toolbar.dart';
import '../widget/custom_button.dart';
import '../widget/text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonToolbar(title: "Otp Verification"),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
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
              SizedBox(
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
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                textColor: Colors.white,
                value: "Verify phone number",
                buttonColor: Properties.primaryColor,
                onPressed: () {

                },
              ),
              SizedBox(
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
                    onPressed: (){},
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

