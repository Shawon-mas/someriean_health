import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/routes/routes.dart';
import 'package:somerian_health/view/widget/custom_button.dart';

import '../../global/properties.dart';
import '../widget/primary_toolbar.dart';
import '../widget/text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryToolbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //assets/images/doctors.jpg
            Image.asset('assets/images/doctors.jpg'),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              value: "Enter phone number to continue",
              size: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: makeInput(),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(

              padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: CustomButton(
                textColor: Colors.white,
                value: "Continue",
                buttonColor: Properties.primaryColor,
                onPressed: () {
                  if (phone.text.toString().isEmpty) {
                    final snackBar = SnackBar(
                      backgroundColor: Properties.primaryColor,
                      content: Text("Please enter phone number",style: TextStyle(color: Colors.white),),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else{
                    Get.toNamed(otp);
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          controller: phone,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.numbers),
              labelText: "Enter phone number",
              hintText: "Enter your phone number",
              /*  errorText: _validate ? 'Number Can\'t Be Empty' : null,*/
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
