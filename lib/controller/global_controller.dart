import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:somerian_health/global/global_constants.dart';

import '../routes/routes.dart';
import '../utilites/shared_prefs.dart';

class GlobalController extends GetxController {
  final box = Hive.box(hiveBox);
  final backendAsFirebase = true;
  //bool isLogin=false;

  getCurrentUser() {
    if (backendAsFirebase) {
      _getCurrentUserFromFirebase();
      _redirect(box.get(userExists) ?? false);
    } else {}
  }

  _getCurrentUserFromFirebase() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      box.put(userExists, true);
    } else {
      box.put(userExists, false);
    }
  }

  getCurrentUserFromServer() async{
    bool isLogin= await SharedPrefs().getIsLogin()??false;

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (isLogin) {
        Get.offAllNamed(bottom);
      } else {
        Get.offAllNamed(login);
      }
    });


    //do server response here
  }

  _redirect(bool userExists) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (userExists) {
        Get.offAllNamed(bottom);
      } else {
        Get.offAllNamed(login);
      }
    });
  }

  @override
  void onInit() {
    //getCurrentUser();
    super.onInit();
  }
}
