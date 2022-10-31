import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../global/properties.dart';

import '../../../../model/medical_history.dart';
import '../../../../model/vaccination-model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';


class MEDICALRECORDS extends StatelessWidget {
  const MEDICALRECORDS({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  CommonToolbar(title: "Hospital Records"),
      body: Column(
        children: [
          CustomContainer(value: "All Records"),
          SizedBox(height: 20.h,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: recordsList.length,
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
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: TextWidget(
                                      edgeInsetsGeometry: EdgeInsets.all(5),
                                      value:recordsList[index].date.toString(),
                                      size: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: TextWidget(
                                      edgeInsetsGeometry: EdgeInsets.all(5),
                                      value:recordsList[index].name.toString(),
                                      size: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(

                              children: [
                                Expanded(
                                  flex:10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(3),
                                        value:recordsList[index].problem.toString(),
                                        size: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: Properties.colorTextBlue,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(3),
                                        value:recordsList[index].schedule.toString(),
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.colorTextBlue,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(3),
                                        value:recordsList[index].doctor.toString(),
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.colorTextBlue,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(3),
                                        value:recordsList[index].location.toString(),
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.colorTextBlue,
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                    flex:5,
                                    child: Row(
                                  children: [
                                    TextWidget(
                                      edgeInsetsGeometry: EdgeInsets.zero,
                                      value:"View Report",
                                      size: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: Properties.primaryColor,
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded,color:  Properties.primaryColor,)
                                  ],
                                ))


                              ],
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
