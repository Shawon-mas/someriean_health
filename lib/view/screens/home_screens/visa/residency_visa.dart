import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/visa_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
class ResidencyVisa extends StatelessWidget {
  final controller=Get.put(VisaScreeningController());
  final String title;
   ResidencyVisa({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            customTextField(
                textInputType: TextInputType.number,
                enabled: true,
                textEditingController:
                controller.mobileController,
                helperText: "Mobile Number"),
          ],
        ),
      ),

    );
  }
  Widget customTextField(
      {required TextEditingController textEditingController,
        required String helperText,
        TextInputType? textInputType,
        EdgeInsets? edgeInsets,
        bool? enabled = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helperText,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: textInputType,
          enabled: enabled,
          controller: textEditingController,
          decoration: InputDecoration(
            /* helperText: helperText,
            helperStyle: TextStyle(
              color: Colors.grey,
            ),*/
            contentPadding: edgeInsets,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
               BorderSide(color: Properties.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
