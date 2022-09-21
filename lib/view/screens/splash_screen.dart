import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/controller/global_controller.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/login_screen.dart';

import 'auth_screen.dart';

class SplashScreen extends StatelessWidget {
  final _controller = Get.put(GlobalController());

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Properties.primaryColor,
          ),
        ),
        Center(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/images/splash.png'),
            ),
          ),
        )
      ],
    ));
  }
}
