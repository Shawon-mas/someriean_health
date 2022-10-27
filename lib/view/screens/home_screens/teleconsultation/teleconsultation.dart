import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import '../home_care/home_care_doctor.dart';
import '../home_care/home_care_nurse.dart';


class Teleconsultation extends StatelessWidget {
  const Teleconsultation({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      'Doctor',
      'Nurse',

    ];
    return Scaffold(
      appBar:  CommonToolbar(title: "Teleconsultation"),
      body: Column(
        children: [
          CustomContainer(value: "Select Facility"),
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
                        if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareNurse(title: _center[index],)));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareDoctor(title: _center[index],)));
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FacilityScreen(title: _center[index],)));
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
