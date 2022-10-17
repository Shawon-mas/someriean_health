import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';

import '../../../../global/properties.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import 'location_one.dart';
import 'location_two.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Color _color = Colors.white; // declare it here
  Color _text_color = Properties.colorTextBlue; // declare it here

  @override
  Widget build(BuildContext context) {
     var location_one="Abu Dhabi & Al Ain";
     var location_two="Dubai & Northern Emirates";
    return Scaffold(
      appBar: CommonToolbar(title: 'Find us'),
      body: Column(
        children: [
          CustomContainer(value: "Select location"),
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationOneScreen(title: location_one,)));
                   /* setState(() {
                      _color=Properties.primaryColor;
                      _text_color=Colors.white;

                    });*/

                  },
                  child: Container(
                    decoration: BoxDecoration(
                    //  border: Border.all(color: Colors.grey),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                      color: Properties.primaryColor,
                    ),
                    width: double.maxFinite,
                    height: 50.h,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: TextWidget(
                        value: location_one,
                        size: 14.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationTwoScreen(title: location_two,)));

                  },
                  child: Container(
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
                        value: location_two,
                        size: 14.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
