
import 'package:flutter/material.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/login_screen.dart';
import '../widget/custom_button.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color:  Properties.primaryColor,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splash.png'),
                  SizedBox(height: 50,),
                  CustomButton(
                    value: "Login",
                    buttonColor: Colors.white,onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                  },),
                  SizedBox(height: 10,),
                  CustomButton(
                    value: "Register",
                    buttonColor: Colors.white,onPressed: (){

                  },),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}


