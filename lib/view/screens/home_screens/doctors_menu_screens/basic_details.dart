import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:somerian_health/global/properties.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';


class BasicDetailsScreen extends StatelessWidget {
  final DoctorAppointmentController controller;
  BasicDetailsScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonToolbar(title: 'Doctors'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: 50.h,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextWidget(
                  value: "Please provide basic detalis",
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: customTextField(
                            textEditingController:
                                controller.firstNameController,
                            helperText: "First Name"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(
                            textEditingController:
                                controller.lastNameController,
                            helperText: "Last Name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.mobileController,
                      helperText: "Mobile No"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.emailController,
                      helperText: "Email Id"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.genderController,
                      helperText: "Gender"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.nationalityController,
                      helperText: "Nationality"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.timeAndDateController,
                      helperText: "Time and date"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppointmentButton(
          onPressed: () {
            controller.proceedDialog(context, controller);
          },
          value: 'Proceed',
        ),
      ),
    );
  }

  Widget customTextField(
      {required TextEditingController textEditingController,
      required String helperText,
      bool? enabled = false}) {
    return TextField(
      enabled: enabled,
      controller: textEditingController,
      decoration: InputDecoration(
        helperText: helperText,
        helperStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Properties.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}