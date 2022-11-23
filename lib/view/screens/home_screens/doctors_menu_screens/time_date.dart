import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonToolbar(title: 'Doctors'),
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
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
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
                                  textColor: Colors.grey,
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
                        value: 'Select Preferred Time',
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
                                  textColor: Colors.grey,
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller:controller.messageController,
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
                              isLoading: controller.isProcessing.value,
                              onPressed: () {
                                if (controller.valuePayment.value != "Cash on Board") {
                                  infoSnackBar(context, "Coming Soon");
                                } else {
                                  controller.proceedPayment(context, controller);
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




           /* Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppointmentButton(
                onPressed: () {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => BasicDetailsScreen(controller: controller,),),);
                  controller.timeAndDateController.text =
                      '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}, ${controller.selectedTime.value.format(context).toString()}';
                },
                value: 'Next',
              ),
            ),*/
            SizedBox(
              height: 20.h,
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
