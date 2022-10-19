import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/controller/doctor_appointment_controller.dart';
import 'package:somerian_health/controller/healthcare_controller.dart';


import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';

class CompleteHealthcareScreen extends StatelessWidget {
  final HealthcareController controller;
  const CompleteHealthcareScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete Payment'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Image.asset('assets/images/check.png',height: 100.h,width: 100.w,),
              TextWidget(
                value:
                'Appointment Booked',
                size: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: Properties.fontColor,
              ),
              SizedBox(height: 10.h,),
              Container(
               // height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        value:
                        'Your Appointment' ,
                        size: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: Properties.fontColor,
                      ),
                      TextWidget(
                        value:
                        'Date: ${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                      ),
                      TextWidget(
                        value:
                        'Time: ${controller.selectedTime.value
                            .format(context)
                            .toString()}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                      ),
                      TextWidget(
                        value:
                        'Location: ${controller.selectedLocation.value}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
