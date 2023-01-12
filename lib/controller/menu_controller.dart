import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';

import '../model/user/update_user_profile_model.dart';
import '../utilites/api_services.dart';
import '../utilites/shared_prefs.dart';
import 'package:http/http.dart' as http;

class MenuController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  var imagePath = "".obs;
  var userDoc =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  var name = "".obs;
  var emarites = "".obs;


  @override
  void onInit() {
   // getUserInfo();
    getUserData();
    super.onInit();
  }


  getUserData()async {

    Map<String,dynamic> body={
      ApiKeyName.OTP_NUMBER:await SharedPrefs().getUserNumber(),
    };
    try{
      var response=await http.post(Uri.parse(ApiServices.OTP_URL_LOGIN),
          body: body,
          headers: ApiServices().defaultHeader
      );
      if(response.statusCode==200){
        final updateUserProfileModel = updateUserProfileModelFromJson(response.body);
        if (updateUserProfileModel!.status! && updateUserProfileModel.data != null) {

          /*Get all data*/
          await SharedPrefs().generalStoreData(value: response.body, key: "user_data");
          String? jsonData = await SharedPrefs().generalGetData(key: "user_data");
          if (jsonData != null) {
            final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);

            imagePath.value=updateUserProfileModel!.data!.appsUserProfilePic!;
            emarites.value=updateUserProfileModel.data!.appsUserEmiratesIdNumber!;
            name.value=updateUserProfileModel.data!.appsUserFirstName!+' '+updateUserProfileModel.data!.appsUserLastName!;
            print(imagePath.value);
            print(emarites.value);
            print(name.value);
            print(await SharedPrefs().getUserId());

          }
        }

      }

    }catch(e){

      if (kDebugMode) {
        print(e.toString());
      }
    }

  }
}
