import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../../model/emergency_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class EmergencyContact extends StatelessWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Emergency Contact'),
      body: Column(
        children: [
          Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 300 / 250,
                children: List.generate(emergency_model.length, (index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Properties.primaryColor,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                emergency_model[index].image.toString(),
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white60,
                                          Properties.primaryColor,
                                        ])),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(0),
                                        value: emergency_model[index].name.toString(),
                                        size: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: Colors.white,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.all(0),
                                        value: emergency_model[index].number.toString(),
                                        size: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          )

                        ],
                      ),

                    ),
                  );
                }),
              )
          )
        ],
      ),
    );
  }
}
