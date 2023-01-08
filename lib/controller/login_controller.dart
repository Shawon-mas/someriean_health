import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/view/screens/complete_profile_screen.dart';
import 'package:somerian_health/view/screens/otp_screen.dart';

import '../global/global_constants.dart';
import '../routes/routes.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  var isValidNumber = false;
  var phoneNumber = "";
  var isSendingOtp = false.obs;
  var isVerifyingOtp = false.obs;
  final auth = FirebaseAuth.instance;
  String verificationId = "";
  var countryCode = "AE".obs;
  

  initPlatformState() async {
    String platformVersionin;
    try {
      platformVersionin = await FlutterSimCountryCode.simCountryCode ?? "AE";
      countryCode.value = platformVersionin.toUpperCase();
    } on PlatformException {
      countryCode.value = "AE";
    }
    logger.d(countryCode.value);
  }




  sendOtp(BuildContext context, LoginController _controller) async {
    isSendingOtp.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        verificationId = credential.verificationId!;
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.e(e.code);
        logger.e(e.message);
        if (e.code == 'invalid-phone-number') {
          logger.d('The provided phone number is not valid.');
          errorSnackBar(context, 'The provided phone number is not valid.');
        } else if (e.code == 'invalid-verification-code') {
          logger.d('The provided otp is not valid.');
          errorSnackBar(context, 'The provided otp is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        isSendingOtp.value = false;
      /*  Get.to(
          () => OtpScreen(
            controller: _controller,
            verificationId: verificationId,
          ),
        );*/
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  registerUser(String otp, String verificationId, BuildContext context) async {
    isVerifyingOtp.value = true;
    logger.d(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    var result = await auth.signInWithCredential(credential);
    isVerifyingOtp.value = false;
    User? user = result.user;
    if (user != null) {
      FirebaseFirestore.instance
          .collection(DbCollections.collectionPatients)
          .get()
          .then((value) {
            
        List<String> numbers = [];
        for (var patient in value.docs) {
          numbers.add(patient.id);
        }
        if (numbers.contains(phoneNumber)) {
          successSnackBar(context, "Logged in successfully");
          Get.offAllNamed(bottom);
        } else {
          infoSnackBar(context, "Complete your profile to proceed");
          Get.to(
            () => CompleteProfileScreen(
              mobileNumber: phoneNumber,
            ),
          );
        }
      });
    }
  }

  @override
  void onInit() {
    initPlatformState();
    super.onInit();

  }


}
