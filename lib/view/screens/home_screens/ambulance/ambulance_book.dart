import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../controller/ambulance_controller.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/global_constants.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
class AmbulanceBooking extends StatelessWidget {
  final AmbulanceController controller;
  final DoctorAppointmentController controllerDoc;
  AmbulanceBooking({Key? key, required this.controller, required this.controllerDoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CommonToolbar(title: 'Ambulance Booking'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 110.h,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Image.network(
                        controller.selectedAmbulance.image,
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          value: controller.selectedAmbulance.name,
                          edgeInsetsGeometry: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          size: 18.sp,
                          fontWeight: FontWeight.w700,
                          textColor: Properties.fontColor,
                        ),
                        TextWidget(
                          edgeInsetsGeometry: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          value: controller.selectedAmbulance.service,
                          size: 14.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Properties.fontColor,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    value: 'Select Preferred Date',
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Properties.colorTextBlue,
                  ),

                  InkWell(
                    onTap: () {
                      controller.selectDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                                () => TextWidget(
                              value:
                              '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                              size: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  TextWidget(
                    value: 'Select Pick Up Time',
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Properties.colorTextBlue,
                  ),
                  InkWell(
                    onTap: () {
                      controller.selectTime(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                                () => TextWidget(
                              value: controller.selectedTime.value
                                  .format(context)
                                  .toString(),
                              size: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/clock.png')
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  TextWidget(
                    value: 'Select Drop Off Time',
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Properties.colorTextBlue,
                  ),
                  InkWell(
                    onTap: () {
                      controller.selectTime(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                                () => TextWidget(
                              value: controller.selectedTime.value
                                  .format(context)
                                  .toString(),
                              size: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/clock.png')
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),

                ],
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
                            controllerDoc.firstNameController,
                            helperText: "First Name"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(
                            textEditingController:
                            controllerDoc.lastNameController,
                            helperText: "Last Name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controllerDoc.mobileController,
                      helperText: "Mobile No"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controllerDoc.emailController,
                      helperText: "Email Id"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controllerDoc.genderController,
                      helperText: "Gender"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controllerDoc.nationalityController,
                      helperText: "Nationality"),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Obx(
                              () => DropdownButton(
                            hint: const Text('Select Payment Method'),
                            isExpanded: true,
                            value: controllerDoc.valuePayment.value == "" ? null : controllerDoc.valuePayment.value,
                            underline: const SizedBox(),
                            onChanged: (newValue) {
                              controllerDoc.valuePayment.value = newValue as String;
                            },
                            items: controllerDoc.paymentMethods.map((valuItem) {
                              return DropdownMenuItem(
                                value: valuItem,
                                child: Text(valuItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ListTile(
                          dense: false,
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            icon: Icon(Icons.attach_file_outlined),
                            onPressed: () {
                              controllerDoc.filePicker();
                            },
                          ),
                          title: Obx(
                                () => Text((controllerDoc.selectedFile.value),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller:controllerDoc.messageController,
                        enabled: true,
                        decoration: InputDecoration(
                          helperText: 'Message',
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 50, 0, 50),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => AppointmentButton(
                          isLoading: controllerDoc.isProcessing.value,
                          onPressed: () {
                            if (controllerDoc.valuePayment.value != "Cash on Board") {
                              infoSnackBar(context, "Coming Soon");
                            } else {
                              controllerDoc.proceedPayment(context, controllerDoc);
                              //test();
                            }
                          },
                          value: 'Proceed',
                        )),
                      ),
                    ],
                  )

                ],
              ),
            ),

          ],
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
