import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/routes/routes.dart';
import 'package:somerian_health/view/screens/complete_profile_screen.dart';
import 'package:somerian_health/view/widget/custom_button.dart';

import '../../controller/login_controller.dart';
import '../../global/properties.dart';
import '../widget/primary_toolbar.dart';
import '../widget/text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final _controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryToolbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //assets/images/doctors.jpg
            Image.asset('assets/images/doctors.jpg'),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              value: "Enter phone number to continue",
              size: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: makeInput(_controller),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.h,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: Obx(() {
            return CustomButton(
              textColor: Colors.white,
              isLoading: _controller.isSendingOtp.value,
              value: "Continue",
              buttonColor: Properties.primaryColor,
              onPressed: () {
                if (_controller.phoneController.text.isEmpty) {
                  errorSnackBar(context, "Input fields can not be empty");

                } else if(_controller.phoneController.text.length<9){
                  errorSnackBar(context, "Invalid Number");
                }

                else {
                  Get.to(()=> OtpScreen(controller: _controller,));
                  _controller.isSendingOtp.value=true;
                 // _controller.sendOtp(context, _controller);
                  //Get.to(()=>OtpScreen(controller: _controller));
                }
              },
            );
          }),
        ),
      ),
    );
  }

  Widget makeInput(LoginController _controller) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(left: 10.h),
          child:  InternationalPhoneNumberInput(
                maxLength: 9,
                isEnabled: true,
                textFieldController: _controller.phoneController,
                initialValue: PhoneNumber(
                  isoCode: "AE",
                ),
                onInputChanged: (PhoneNumber number) {
                  _controller.phoneNumber = number.phoneNumber!;
                },
                onInputValidated: (bool value) {
                  _controller.isValidNumber = value;
                  logger.d(value);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  setSelectorButtonAsPrefixIcon: true,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                hintText: "508789706",
                inputBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                onSaved: (PhoneNumber number) {
                  print('On Saved: ');
                },
            ),

        ),
        /*const SizedBox(
          height: 10,
        ),*/
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
