import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import 'home_care_doctor.dart';
import 'home_care_nurse.dart';

class HomeCareFacility extends StatefulWidget {
  const HomeCareFacility({Key? key, }) : super(key: key);

  @override
  State<HomeCareFacility> createState() => _HomeCareFacilityState();
}

class _HomeCareFacilityState extends State<HomeCareFacility> {
  int selectionStatus=-1;
  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      'Doctor',
      'Nurse/Home PCR',
      'Physiotherapist',
      'Home Care Assistant',
    ];

    return Scaffold(
      appBar:  CommonToolbar(title: "Home Care"),
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

                        setState(() {

                          if(index==1){
                            selectionStatus=index;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareNurse(title: _center[index],)));

                          }else{
                            selectionStatus=index;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareDoctor(title: _center[index],)));
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FacilityScreen(title: _center[index],)));
                          }

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
