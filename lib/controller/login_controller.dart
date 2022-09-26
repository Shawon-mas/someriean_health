import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  sendOtp(BuildContext context, LoginController _controller) async {
    isSendingOtp.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        verificationId = credential.verificationId!;
      },
      verificationFailed: (FirebaseAuthException e) {
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
        Get.to(
          () => OtpScreen(
            controller: _controller,
            verificationId: verificationId,
          ),
        );
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
          Get.offAllNamed(home);
        } else {
          infoSnackBar(context, "Complete your profile to proceed");
          Get.to(
            () => CompleteProfileScreen(
              mobileNumber: phoneNumber,
              uid: user.uid,
            ),
          );
        }
      });
    }
  }

/*final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );*/
}
