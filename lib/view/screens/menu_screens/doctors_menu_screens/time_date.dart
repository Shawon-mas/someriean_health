import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../../controller/complete_profile_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import 'basic_details.dart';
class TimeDateScreen extends StatefulWidget {
  final String image,name,title,location;


   TimeDateScreen({Key? key, required this.image, required this.name, required this.title, required this.location}) : super(key: key);

  @override
  State<TimeDateScreen> createState() => _TimeDateScreenState();
}

class _TimeDateScreenState extends State<TimeDateScreen> {
  TimeOfDay _timeOfDay=TimeOfDay(hour: 8, minute: 30);
  final _controller = Get.put(CompleteProfileController());
  void _selectTime(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),).then((value) {
          setState(() {
            _timeOfDay=value!;
          });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [
          Container(
            height: 110.h,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(widget.image,height:100,width: 100,fit: BoxFit.cover,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        value: widget.name,
                        size: 18.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Properties.fontColor,
                      ),
                      TextWidget(
                        value: widget.title,
                        size: 14.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                      ),
                      TextWidget(
                        value: widget.location,
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
                  value:
                  'Select Preferred Date',
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.colorTextBlue,
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: () {
                    _controller.selectDate(context);
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
                            '${_controller.selectedDate.value.day}/${_controller.selectedDate.value.month}/${_controller.selectedDate.value.year}',
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
                SizedBox(height: 10.h,),
                TextWidget(
                  value:
                  'Select Preferred Time',
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor:Properties.colorTextBlue,
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: () {
                    _selectTime();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 40.h,
                    width: double.infinity,
                    child: Row(
                      children: [
                        TextWidget(
                            value:
                            _timeOfDay.format(context).toString(),
                            size: 14.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.grey,
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
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BasicDetailsScreen()));
              },
              value:'Next' ,
            ),
          ),
          SizedBox(height:20.h,),
        ],
      ),
    );
  }
}
