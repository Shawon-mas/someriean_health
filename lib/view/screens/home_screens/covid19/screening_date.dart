import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:somerian_health/view/screens/home_screens/vaccination/vaccination_details.dart';

import '../../../../controller/covid19_appionment_controller.dart';
import '../../../../controller/vaccination_appionment_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
class SCreeningDate extends StatelessWidget {
 final String title;
 final Covid19AppointmentController controller;
  const SCreeningDate({Key? key, required this.controller, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CommonToolbar(title: title),
     body: Column(
      children: [
       Container(
        height: 110.h,
        width: double.infinity,
        color: Colors.grey,
        child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           TextWidget(
            value: 'Facility',
            textColor: Properties.colorTextBlue,
            size: 14.sp,
            fontWeight: FontWeight.w700,
           ),
           Container(
            height: 40.h,
            width: double.infinity,

            decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(10)),
             color: Colors.white,
            ),
            child:Center(
              child: TextWidget(
               value: controller.selectedCenter.name,
               textColor: Properties.colorTextBlue,
               size: 14.sp,
               fontWeight: FontWeight.w700,
              ),
            ) ,
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
         // Navigator.push(context, MaterialPageRoute(builder: (context) => VaccinationDetails(controller: controller,)));
          controller.timeAndDateController.text =
          '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}, ${controller.selectedTime.value
              .format(context)
              .toString()}';
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
