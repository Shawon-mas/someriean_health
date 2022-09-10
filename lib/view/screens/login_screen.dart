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
  final formKey=GlobalKey<FormState>();
  bool _isObscure = true;
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
            TextWidget(value: "Login", size: 18.sp,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: makeInput(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
              child: CustomButton(
                textColor: Colors.white,
                value: "Login",
                buttonColor: Properties.primaryColor,onPressed: ()
              {

              },),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(value: "Don't have account?", size: 14.sp,),
                SizedBox(width: 5.w,),
                TextWidget(value: "Register", size: 14.sp,textColor: Properties.primaryColor,onPressed: (){
                  Get.toNamed(signup);
                },),
              ],
            )


          ],
        ),
      ),
    );
  }

 Widget makeInput() {
    return Form(
        child: Column(
          children: [
            TextFormField(
              validator: (value){
                if (value!.isEmpty) {
                  return "Enter your phone number";
                }

              },
              keyboardType: TextInputType.number,
              controller: phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  labelText: "Enter phone number",
                  hintText: "Enter your phone number",
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
              obscureText:_isObscure,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(onPressed: ()
                  {
                    setState(() {
                      _isObscure = !_isObscure;
                    });

                  }, icon: Icon(_isObscure?Icons.visibility : Icons.visibility_off,)),
                  hoverColor: Colors.red,
                  labelText: "Enter Password",
                  hintText: "Enter your Password",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration:
                      TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 2,

                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

          ],

    )
    );
  }
}




