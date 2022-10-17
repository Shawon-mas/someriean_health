import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class LocationTwoScreen extends StatelessWidget {
  final String title;
  const LocationTwoScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _center=[
      'Somerian Clinic',
      'Somerian Hospital',
      'Somerian Visa Screening Center',
      'Covid-19 Testing Center',
      'Vaccination Center',
    ];
    return Scaffold(
      appBar:  CommonToolbar(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView.builder(
            itemCount: _center.length,
            itemBuilder: (context,index)
            {
              return InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationTwoScreen(title: location_two,)));

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
    );
  }
}
