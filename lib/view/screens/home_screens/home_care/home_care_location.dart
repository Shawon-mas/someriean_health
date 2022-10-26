import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import 'home_care_facility.dart';

class HomeCareLocation extends StatelessWidget {

  const HomeCareLocation({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      'Abu Dhabi',
      'Al Ain',
      'Dubai',
      'Ajman',
      'Sharjah',
      'Umm Al Quwain',
      'Ras Al Khaima',
      'Fujairah',
    ];
    return Scaffold(
      appBar:  CommonToolbar(title: "Home Care"),
      body: Column(
        children: [
          CustomContainer(value: "Select location"),
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
                        if(index==null){
                          return;
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareFacility()));

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
