import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/screens/home_screens/medical_history/pcr.dart';
import 'package:somerian_health/view/screens/home_screens/medical_history/vaccination.dart';
import 'package:somerian_health/view/screens/home_screens/reports/reports.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import '../home_care/home_care_doctor.dart';
import '../home_care/home_care_nurse.dart';



class ReportsType extends StatelessWidget {
  const ReportsType({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _reports=[
      'Medical Report',
      'Covid-19 Vaccination',
      'PCR Test Report',
      'Visa Screening Result',

    ];
    return Scaffold(
      appBar:  CommonToolbar(title: "Reports"),
      body: Column(
        children: [
          CustomContainer(value: "View My Report"),
          SizedBox(height: 20.h,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: _reports.length,
                  itemBuilder: (context,index)
                  {
                    return InkWell(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyReports(title: _reports[index],)));


                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Properties.primaryColor,
                        ),
                        width: double.maxFinite,
                        height: 50.h,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextWidget(
                            value: _reports[index],
                            size: 14.sp,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    );

                  }),
            ),
          ),
        ],
      ),


    );
  }
}
