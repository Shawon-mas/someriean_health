import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
import '../doctors_menu_screens/doctors_menu.dart';
import '../specialties_menu/choose_specialty.dart';
class FacilityScreen extends StatelessWidget {
  final String title;
  const FacilityScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _faclity=[
      'Doctors',
      'Specialty',

    ];
    return Scaffold(
      appBar: CommonToolbar(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView.builder(
            itemCount: _faclity.length,
            itemBuilder: (context,index)
            {
              return InkWell(
                onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                  if(index==0){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                  }if(index==1){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseSpecialty()));
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>FacilityScreen(title: _center[index],)));
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
                      value: _faclity[index],
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              );

            }),
      ),
    );
  }
}
