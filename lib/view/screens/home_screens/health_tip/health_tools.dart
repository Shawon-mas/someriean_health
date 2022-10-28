import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../../global/global_constants.dart';
import '../../../widget/text_widget.dart';
import 'calculator_screen.dart';
class HealthTools extends StatelessWidget {
  const HealthTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:
        [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CalculatorScreen()));

              //  CalculatorScreen
            },
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(color: Properties.colorTextBlue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child:  Center(
                child: TextWidget(
                  value:"BMI Calculator",
                  size: 18.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.fontColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              infoSnackBar(context,'Coming soon');
            },
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Properties.colorTextBlue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child:  Center(
                child: TextWidget(
                  value:"Stroke Risk Calculator",
                  size: 18.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.fontColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
