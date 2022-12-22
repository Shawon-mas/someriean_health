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


class MedicalHistory extends StatefulWidget {
  const MedicalHistory({Key? key, }) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  int selectionStatus=-1;
  @override
  Widget build(BuildContext context) {
    List<String> _center=[

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

                        setState(() {


                            selectionStatus=index;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MEDICALRECORDS()));
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FacilityScreen(title: _center[index],)));


                        });


                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.red, //                   <--- border color
                              width: 1.w,
                            ),
                            color:selectionStatus==index?Properties.primaryColor: Colors.white,
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
                              textColor:selectionStatus==index?Colors.white:Properties.primaryColor,
                            ),
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
