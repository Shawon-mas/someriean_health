import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class Document extends StatelessWidget {
  const Document({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [

          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Emirates ID',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload Front Copy',
                  ),
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload Back Copy',
                  ),
                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Passport',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Visa',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Insurance',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Others',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),

        ],
      ),
    );
  }
}
