import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/controller/global_controller.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/login_screen.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  final controller = Get.put(GlobalController());
  late AnimationController _controller;
  late Animation<double> _animation;
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller.getCurrentUserFromServer();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Properties.primaryColor,
          ),
        ),
          Center(
          child: FadeTransition(
            opacity: _animation,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset('assets/images/splash.png'),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
