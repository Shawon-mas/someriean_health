import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:somerian_health/controller/doctor_appointment_controller.dart';


import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../../bottombar_screen.dart';
import '../manage_appiontment/appointment_section.dart';

class CompleteAppointmentScreen extends StatelessWidget {
  final DoctorAppointmentController controller;
  const CompleteAppointmentScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete Payment',
        voidCallback: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBarScreen()));
        },
      ),
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
                      Image.network(controller.selectedDoctor.image,height: 100.h,width: 100.w,),

                      TextWidget(
                        value:
                        controller.selectedDoctor.name,
                        size: 14.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Properties.fontColor,
                        edgeInsetsGeometry: EdgeInsets.all(3),
                      ),
                      TextWidget(
                        value:
                        controller.selectedDoctor.title,
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                        edgeInsetsGeometry: EdgeInsets.all(3),
                      ),
                      TextWidget(
                        value:
                        'Date: ${DateFormat("yyyy-MM-dd").format(controller.selectedDate.value).toString()}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                        edgeInsetsGeometry: EdgeInsets.all(3),
                      ),
                      TextWidget(
                        value:
                        'Time: ${controller.selectedTimeSlot}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                        edgeInsetsGeometry: EdgeInsets.all(3),
                      ),
                      TextWidget(
                        value:
                        'Location: ${controller.selectedDoctor.location}',
                        size: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                        edgeInsetsGeometry: EdgeInsets.all(3),
                      ),


                     /*Obx(() =>  Visibility(
                         visible: controller.valueAppointment.value=='Book for others',
                         child: Column(
                           children: [
                             TextWidget(
                               value:
                               controller.fullNameController.text,
                               size: 14.sp,
                               fontWeight: FontWeight.w700,
                               textColor: Properties.fontColor,
                               edgeInsetsGeometry: EdgeInsets.all(3),
                             ),
                           ],
                         )
                     ))*/
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AppointmentButton(
          onPressed: () {
            Get.off(()=> AppointmentSection());
          },
          value: 'My Appointment',
        ),
      ),
    );
  }
}
