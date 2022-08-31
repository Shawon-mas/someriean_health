import 'package:flutter/material.dart';
import 'package:somerian_health/global/properties.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigatetoauth();
  }
  _navigatetoauth() async{
    await Future.delayed(Duration(milliseconds: 2500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));

  }


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
            child:
            Container(
            child:
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/splash.png'),
            ),
          ),
          )
        ],
      )
    );
  }
}
/*Center(
child: Image.asset('assets/images/main_logo.png'),
),*/
