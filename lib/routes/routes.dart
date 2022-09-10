import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/view/screens/auth_screen.dart';
import 'package:somerian_health/view/screens/login_screen.dart';
import 'package:somerian_health/view/screens/splash_screen.dart';

import '../view/screens/signup_screen.dart';

const splash = "/";
const home = "/home";
const login = "/login";
const signup = "/signup";

final pages = [
  page(splash, SplashScreen(),),
  page(home, SplashScreen(),),
  page(login, LoginScreen(),),
  page(signup, SignUpScreen(),),
];

GetPage page(String name, Widget page) {
  return GetPage(name: name, page: () => page);
}
