import 'package:flutter/material.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/text_widget.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete your profile',),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 40.h,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextWidget(value: "Please provide basic detalis",size: 14.sp,fontWeight: FontWeight.w700,textColor: Colors.black,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                    ),

                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
