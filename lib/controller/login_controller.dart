import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/view/screens/bottombar_screen.dart';
import 'package:somerian_health/view/screens/complete_profile_screen.dart';
import 'package:somerian_health/view/screens/otp_screen.dart';
import 'package:http/http.dart' as http;
import '../global/global_constants.dart';
import '../routes/routes.dart';
import '../utilites/api_services.dart';
import '../utilites/shared_prefs.dart';

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
  var otp=''.obs;
  

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

  sendApiOtp(BuildContext context, LoginController _controller) async{
    isSendingOtp.value = true;
    Map<String,dynamic> body={
      ApiKeyName.OTP_NUMBER:phoneController.text.toString(),
    };
    try{
      var response=await http.post(Uri.parse(ApiServices.OTP_URL),
          body: body,
          headers: ApiServices().defaultHeader
      );
      if(response.statusCode==200){
       isSendingOtp.value = false;
        if (kDebugMode) {
          print("Response:${response.body}");
        }
        var data=json.decode(response.body);
        if (kDebugMode) {
          print("Otp:${data['data']}");
        }
        otp.value=data['data'].toString();
        successSnackBar(context, data['message']);
        Get.to(()=> OtpScreen(controller: _controller,));


      }

    }catch(e){
      isSendingOtp.value = false;
      errorSnackBar(context, 'Something Went Wrong');
      if (kDebugMode) {
        print(e.toString());
      }
    }

  }
  checkUserByNumber(BuildContext context, LoginController _controller) async{
    isVerifyingOtp.value=true;
    Map<String,dynamic> body={
      ApiKeyName.OTP_NUMBER:'+971${phoneController.text.toString()}',
    };
    try{
      var response=await http.post(Uri.parse(ApiServices.OTP_URL_LOGIN),
          body: body,
          headers: ApiServices().defaultHeader
      );
      if(response.statusCode==200){
        isVerifyingOtp.value=true;
        if (kDebugMode) {
          print("Response:${response.body}");
        }
        var data=json.decode(response.body);

        var result=data['data'];
        if(result!=null){
          if (kDebugMode) {
            print("Result:$result");
          }

          await SharedPrefs().saveToken(data['access_token']);
          await SharedPrefs().storeUserId(result['apps_user_id'].toString());
          await SharedPrefs().storeUserNumber(result['apps_user_mobile_number']);

          print(await SharedPrefs().getToken());
          print(await SharedPrefs().getUserId());
          print(await SharedPrefs().getUserNumber());
          successSnackBar(context, data['message']);
          print(data['is_userexist']);
          if(data['is_userexist']==true)
          {
            Get.offAll(()=> BottomBarScreen());
            await SharedPrefs().isLogin(true);
          }else{
            Get.to(CompleteProfileScreen(mobileNumber: _controller.phoneController.text));
          }
        }
      }

    }catch(e){
      isVerifyingOtp.value=false;
      errorSnackBar(context, 'Something Went Wrong');
      if (kDebugMode) {
        print(e.toString());
      }
    }
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
