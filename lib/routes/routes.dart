import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/view/screens/auth_screen.dart';
import 'package:somerian_health/view/screens/login_screen.dart';
import 'package:somerian_health/view/screens/splash_screen.dart';

import '../view/screens/otp_screen.dart';


const splash = "/";
const home = "/home";
const login = "/login";
const otp = "/signup";

final pages = [
  page(splash, SplashScreen(),),
  page(home, SplashScreen(),),
  page(login, LoginScreen(),),
  page(otp, OtpScreen(),),
];

GetPage page(String name, Widget page) {
  return GetPage(name: name, page: () => page);
}
