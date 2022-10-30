import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';
import '../../../../controller/doctor_appointment_controller.dart';
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
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  value: 'Select Preferred Date',
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.colorTextBlue,
                ),
                SizedBox(
                  height: 10.h,
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
                SizedBox(
                  height: 10.h,
                ),
                TextWidget(
                  value: 'Select Preferred Time',
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.colorTextBlue,
                ),
                SizedBox(
                  height: 10.h,
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppointmentButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BasicDetailsScreen(
                      controller: controller,
                    ),
                  ),
                );
                controller.timeAndDateController.text =
                    '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}, ${controller.selectedTime.value.format(context).toString()}';
              },
              value: 'Next',
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
