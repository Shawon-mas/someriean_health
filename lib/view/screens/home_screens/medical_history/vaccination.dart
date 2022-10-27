import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../../model/pcr_model.dart';
import '../../../../model/vaccination-model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import '../home_care/home_care_doctor.dart';
import '../home_care/home_care_nurse.dart';


class VACCINATION extends StatelessWidget {
  const VACCINATION({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  CommonToolbar(title: "Covid-19 Vaccination"),
      body: Column(
        children: [
          CustomContainer(value: "For Medical Use Only"),
          SizedBox(height: 20.h,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: vaccinationList.length,
                  itemBuilder: (context,index)
                  {
                    return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Properties.primaryColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60.h,
                              width: double.infinity,
                              color: Properties.primaryColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextWidget(
                                      value:vaccinationList[index].date.toString(),
                                      size: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextWidget(
                                      value:vaccinationList[index].dose.toString(),
                                      size: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextWidget(
                              value:vaccinationList[index].center.toString(),
                              size: 12.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.colorTextBlue,
                            ),
                            TextWidget(
                              value:vaccinationList[index].facility.toString(),
                              size: 12.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.colorTextBlue,
                            ),
                            TextWidget(
                              value:vaccinationList[index].location.toString(),
                              size: 12.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.colorTextBlue,
                            ),

                          ],
                        ));

                  }),
            ),
          ),
        ],
      ),


    );
  }
}
