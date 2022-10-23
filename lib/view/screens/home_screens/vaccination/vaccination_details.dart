import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/vaccination_appionment_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';

class VaccinationDetails extends StatelessWidget {
 final VaccinationAppointmentController controller;
  const VaccinationDetails({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  final controller = Get.put(VaccinationAppointmentController(context: context));
    return Scaffold(
      appBar: CommonToolbar(title: 'Vaccination Appointment'),
      body: Column(
        children:  [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: customTextField(
                        textEditingController: controller.timeController,
                        helperText: "Time",
                        enabled: true,
                        trailingIcon: IconButton(
                          onPressed: () {
                            controller.selectTime(context);
                          },
                          icon: Icon(
                            Icons.schedule,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: customTextField(
                        textEditingController: controller.dateController,
                        helperText: "Date",
                        enabled: true,
                        trailingIcon: IconButton(
                          onPressed: () {
                            controller.selectDate(context);
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget customTextField(
      {required TextEditingController textEditingController,
        required String helperText,
        bool? enabled = false,
        Widget? trailingIcon}) {
    return TextField(
      enabled: enabled,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: trailingIcon,
        helperText: helperText,
        helperStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
           BorderSide(color: Properties.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
