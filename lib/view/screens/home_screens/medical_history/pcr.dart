import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../../model/pcr_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import '../home_care/home_care_doctor.dart';
import '../home_care/home_care_nurse.dart';


class PCR extends StatelessWidget {
  const PCR({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      '08 Aug 2022 PCR NEGATIVE',
      '09 Aug 2022 PCR NEGATIVE',
      '10 Aug 2022 PCR POSITIVE',


    ];
    return Scaffold(
      appBar:  CommonToolbar(title: "PCR Test Results"),
      body: Column(
        children: [
          CustomContainer(value: "Previous Results"),
          SizedBox(height: 20.h,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,index)
                  {
                    return Row(
                      children: [
                        Container(
                            child:  CircleAvatar(radius: 10,backgroundColor: list[index].color==true?Colors.green:Colors.red)
                        ),
                        TextWidget(
                          value: list[index].status.toString(),
                          size: 18.sp,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.black,
                        ),
                      ],
                    );

                  }),
            ),
          ),
        ],
      ),


    );
  }
}
