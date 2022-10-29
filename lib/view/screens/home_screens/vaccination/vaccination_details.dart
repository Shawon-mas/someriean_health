import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/global_constants.dart';

import '../../../../controller/vaccination_appionment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class VaccinationDetails extends StatelessWidget {
  final VaccinationAppointmentController controller;
  final String title;
  final bool isVisa;
  const VaccinationDetails(
      {Key? key, required this.controller, required this.title, this.isVisa = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final controller = Get.put(VaccinationAppointmentController(context: context));
    return Scaffold(
      appBar: CommonToolbar(title: title),
      body: title == "Vaccination Appointment"
          ? _vaccinationBody()
          : _covidBody(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppointmentButton(
          onPressed: () {
            if (title == "Vaccination Appointment") {
              controller.saveVaccination(controller, context);
            } else {
              logger.d(isVisa);
              if (isVisa) {
                controller.saveCovid(controller,
                      DbCollections.collectionVisaScreeningVaccination, context);
                /* if (isVisa!) {
                  controller.saveCovid(controller,
                      DbCollections.collectionVisaScreeningVaccination);
                } else {
                  controller.saveCovid(controller,
                      DbCollections.collectionCovidScreeningVaccination);
                } */
              } else {
                controller.saveCovid(controller,
                    DbCollections.collectionCovidScreeningVaccination, context);
              }
            }
          },
          value: 'Proceed',
        ),
      ),
    );
  }

  Widget _vaccinationBody() {
    return SingleChildScrollView(
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
                          textEditingController: controller.firstNameController,
                          helperText: "First Name"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: customTextField(
                          textEditingController: controller.lastNameController,
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
                  textEditingController: controller.locationController,
                  helperText: "Location",
                ),
                const SizedBox(
                  height: 20,
                ),
                /* Row(
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
                ), */
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidBody(BuildContext context) {
    return SingleChildScrollView(
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
                          textEditingController: controller.firstNameController,
                          helperText: "First Name"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: customTextField(
                          textEditingController: controller.lastNameController,
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
                  textEditingController: controller.locationController,
                  helperText: "Location",
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  textEditingController: controller.unifiedController,
                  helperText: "Unified ID Number",
                  enabled: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  textEditingController: controller.passportController,
                  helperText: "Passport Number",
                  enabled: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  textEditingController: controller.passportIssueController,
                  helperText: "Passport Issue Date",
                  enabled: true,
                  trailingIcon: IconButton(
                    onPressed: () {
                      controller.passportDate(
                        context,
                        controller.passportIssueDate.value,
                        controller.passportIssueController,
                      );
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  textEditingController:
                      controller.passportExpirationController,
                  helperText: "Passport Expiration Date",
                  enabled: true,
                  trailingIcon: IconButton(
                    onPressed: () {
                      controller.passportDate(
                        context,
                        controller.passportExpirationDate.value,
                        controller.passportExpirationController,
                      );
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  textEditingController: controller.emiratesController,
                  helperText: "Emirates ID (if possible)",
                  enabled: true,
                ),
                const SizedBox(
                  height: 20,
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
          borderSide: BorderSide(color: Properties.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
