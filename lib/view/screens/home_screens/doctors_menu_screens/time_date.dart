import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somerian_health/global/properties.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/global_constants.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import 'basic_details.dart';

class TimeDateScreen extends StatelessWidget {
  final DoctorAppointmentController controller;
  TimeDateScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.valueAppointment.value = 'Book for Self';
        controller.fullNameController.clear();
        controller.othersEmiratesIdController.clear();
        controller.relationController.clear();
        controller.numberController.clear();
        controller.selectedDate.value = DateTime.now();
        controller.timeSlotList.clear();
        controller.tap.value = false;
        controller.selectedTimeSlot.value = '';
        controller.timeId.value = '';
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CommonToolbar(
          title: 'Doctors',
        ),
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
                          controller.selectedDoctor.image,
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              value: controller.selectedDoctor.name,
                              edgeInsetsGeometry: EdgeInsets.only(
                                  top: 5, left: 10, right: 10, bottom: 5),
                              size: 18.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Properties.fontColor,
                            ),
                            TextWidget(
                              edgeInsetsGeometry: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              value: controller.selectedDoctor.title,
                              size: 14.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.fontColor,
                            ),
                            TextWidget(
                              edgeInsetsGeometry: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 5),
                              value: controller.selectedDoctor.location,
                              size: 14.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.fontColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(() => InkWell(
                              onTap: () {
                                controller.selectDate(context);
                                controller.tap.value = true;
                              },
                              child: Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        value: controller.tap.value == true
                                            ? DateFormat("yyyy-MM-dd")
                                                .format(controller
                                                    .selectedDate.value)
                                                .toString()
                                            : 'Select Date',
                                        size: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: Colors.black,
                                        edgeInsetsGeometry: EdgeInsets.zero,
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Row(
                              children: [
                                controller.timeSlotList.isEmpty
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: TextWidget(
                                          value: 'No Time Slot Found',
                                          size: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          textColor: Colors.black,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          controller.getTimeSlot(context);
                                        },
                                        child: Container(
                                          width: 200.w,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Row(
                                            children: [
                                              TextWidget(
                                                value: controller.selectedTimeSlot.value == ''
                                                    ? 'Pick Slot'
                                                    : controller
                                                        .selectedTimeSlot.value,
                                                size: 14.sp,
                                                fontWeight: FontWeight.w700,
                                                textColor: Colors.black,
                                              ),
                                              Spacer(),
                                              Icon(Icons.watch_later_sharp)
                                            ],
                                          ),
                                        ),
                                      ),
                                Spacer(),
                                Visibility(
                                    visible: !controller.isTimeSlotLoaded.value,
                                    child: SizedBox(
                                        height: 30.h,
                                        width: 30.w,
                                        child: CircularProgressIndicator(
                                          color: Properties.primaryColor,
                                        )))
                              ],
                            )),
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
                            textEditingController:
                                controller.emiratesController,
                            helperText: "Emirates Id"),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextField(
                            textEditingController:
                                controller.nationalityController,
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
                                  hint: const Text('For Whom'),
                                  isExpanded: true,
                                  value: controller.valueAppointment.value == ""
                                      ? null
                                      : controller.valueAppointment.value,
                                  underline: const SizedBox(),
                                  onChanged: (newValue) {
                                    controller.valueAppointment.value =
                                        newValue as String;
                                    if (newValue == 'Book for Self') {
                                      controller.fullNameController.clear();
                                      controller.othersEmiratesIdController
                                          .clear();
                                      controller.relationController.clear();
                                      controller.numberController.clear();
                                      controller.isSelf.value = "Yes";
                                      print(controller.isSelf.value);
                                    } else {
                                      controller.isSelf.value = "No";
                                      print(controller.isSelf.value);
                                    }
                                  },
                                  items: controller.appointmentType
                                      .map((valuItem) {
                                    return DropdownMenuItem(
                                      value: valuItem,
                                      child: Text(valuItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Obx(() => Visibility(
                                  visible: controller.valueAppointment.value ==
                                      'Book for Others',
                                  child: Column(
                                    children: [
                                      customTextField(
                                          enabled: true,
                                          textEditingController:
                                              controller.fullNameController,
                                          helperText: "Full Name"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      customTextField(
                                          enabled: true,
                                          textEditingController: controller
                                              .othersEmiratesIdController,
                                          helperText: "Emirates Id"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      customTextField(
                                          enabled: true,
                                          textEditingController:
                                              controller.relationController,
                                          helperText: "Relationship"),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      customTextField(
                                          textInputType: TextInputType.number,
                                          enabled: true,
                                          textEditingController:
                                              controller.numberController,
                                          helperText: "Mobile Number"),
                                    ],
                                  ),
                                )),
                            //    Obx(() => controller.valueAppointment.value == 'Book for Self'?controller.fullNameController.clear():),

                            SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(() => AppointmentButton(
                                    isLoading: controller.isProcessing.value,
                                    onPressed: () {
                                      if (controller.valueAppointment.value ==
                                          '') {
                                        errorSnackBar(
                                            context, 'For Whom Required');
                                        if (controller.valueAppointment.value ==
                                            'Book for Others') {
                                          if (controller.fullNameController.text
                                              .isEmpty) {
                                            errorSnackBar(
                                                context, 'Full Name Required');
                                          } else if (controller
                                              .othersEmiratesIdController
                                              .text
                                              .isEmpty) {
                                            errorSnackBar(context,
                                                'Emirates ID Required');
                                          } else if (controller
                                              .relationController
                                              .text
                                              .isEmpty) {
                                            errorSnackBar(context,
                                                'Relationship Required');
                                          } else if (controller
                                              .othersEmiratesIdController
                                              .text
                                              .isEmpty) {
                                            errorSnackBar(context,
                                                'Mobile Number Required');
                                          } else {
                                            // controller.proceedOthersPayment(context, controller);
                                            controller.bookedDoctorAppointment(
                                                context, controller);
                                          }
                                        } else {
                                          // controller.bookedDoctorAppointment(context, controller);
                                        }
                                      } else {
                                        controller.bookedDoctorAppointment(
                                            context, controller);
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
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      {required TextEditingController textEditingController,
      required String helperText,
      TextInputType? textInputType,
      EdgeInsets? edgeInsets,
      bool? enabled = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helperText,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: textInputType,
          enabled: enabled,
          controller: textEditingController,
          decoration: InputDecoration(
            /* helperText: helperText,
            helperStyle: TextStyle(
              color: Colors.grey,
            ),*/
            contentPadding: edgeInsets,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Properties.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
/*
 if (controller.valuePayment.value != "Cash on Board") {
                                  infoSnackBar(context, "Coming Soon");
                                } else {
                                  controller.proceedPayment(context, controller);
                                }

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
                                value: controller.valuePayment.value == "" ? null : controller.valuePayment.value,
                                underline: const SizedBox(),
                                onChanged: (newValue) {
                                  controller.valuePayment.value = newValue as String;
                                },
                                items: controller.paymentMethods.map((valuItem) {
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
                              controller.filePicker();
                                },
                              ),
                              title: Obx(
                                    () => Text((controller.selectedFile.value),
                                ),
                              ),
                            ),
                          ),
 */
