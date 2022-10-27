import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/screens/home_screens/medical_history/pcr.dart';
import 'package:somerian_health/view/screens/home_screens/medical_history/vaccination.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import '../home_care/home_care_doctor.dart';
import '../home_care/home_care_nurse.dart';
import 'hospital_records.dart';


class MedicalHistory extends StatelessWidget {
  const MedicalHistory({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      'PCR Test Result',
      'Covid-19 Vaccination',
      'Hospital Records',

    ];
    return Scaffold(
      appBar:  CommonToolbar(title: "Medical History"),
      body: Column(
        children: [
          CustomContainer(value: "View My Medical History"),
          SizedBox(height: 20.h,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: _center.length,
                  itemBuilder: (context,index)
                  {
                    return InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationTwoScreen(title: location_two,)));
                        if(index==0){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PCR()));
                        }
                        if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VACCINATION()));
                        }
                        if(index==2){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MEDICALRECORDS()));

                        }

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
                            value: _center[index],
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
