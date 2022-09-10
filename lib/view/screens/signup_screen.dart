import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../global/properties.dart';
import '../../routes/routes.dart';
import '../widget/custom_button.dart';
import '../widget/primary_toolbar.dart';
import '../widget/text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
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
            SizedBox(height: 20,),
            TextWidget(value: "Sign Up", size: 18.sp,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: makeInput(),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: CustomButton(
                textColor: Colors.white,
                value: "Register",
                buttonColor: Properties.primaryColor,onPressed: (){


              },),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(value: "Already have account?", size: 14.sp,),
                SizedBox(width: 5.w,),
                TextWidget(value: "Login", size: 14.sp,textColor: Properties.primaryColor,onPressed: (){
                  Get.toNamed(login);
                },),
              ],
            )


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

              labelText: "Name",
              hintText: "Enter your name",
              /*  errorText: _validate ? 'Number Can\'t Be Empty' : null,*/
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),

              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(

          controller: password,
          decoration: InputDecoration(
              hoverColor: Colors.red,
              labelText: "Enter your mobile number",
              hintText: "Enter your mobile number",
              /*errorText: _validate ? 'Password Can\'t Be Empty' : null,*/

              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter your password";
            }
            if (value.length > 10) {
              return " Password length does not exist";
            }
            if (value.length < 6) {
              return "Minimum password length is 6";
            }
          },
          controller: password,
          decoration: InputDecoration(


              hoverColor: Colors.red,
              labelText: "Emirates ID/Passport No",
              hintText: "Emirates ID/Passport No",
              /*errorText: _validate ? 'Password Can\'t Be Empty' : null,*/

              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),

      ],

    );
  }


}
