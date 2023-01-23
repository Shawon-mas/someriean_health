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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: customTextField(
                      textEditingController:
                      controller.firstNameController,
                      helperText: "First Name"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: customTextField(
                      textEditingController:
                      controller.lastNameController,
                      helperText: "Last Name"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            customTextField(
                textEditingController: controller.mobileController,
                helperText: "Mobile No"),
            const SizedBox(
              height: 20,
            ),
            customTextField(
                textEditingController: controller.emailController,
                helperText: "Email Id"),
            const SizedBox(
              height: 20,
            ),
            customTextField(
                textEditingController: controller.genderController,
                helperText: "Gender"),
            const SizedBox(
              height: 20,
            ),
            customTextField(
                textEditingController:
                controller.emiratesController,
                helperText: "Emirates Id"),
            const SizedBox(
              height: 20,
            ),
            customTextField(
                textEditingController:
                controller.nationalityController,
                helperText: "Nationality"),
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
