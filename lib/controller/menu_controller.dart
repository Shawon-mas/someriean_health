import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';

import '../model/user/update_user_profile_model.dart';
import '../utilites/shared_prefs.dart';

class MenuController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  var imagePath = "".obs;
  var userDoc =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  var name = "".obs;
  var emarites = "".obs;

  @override
  void onInit() {
    getUserInfo();
    getUserData();
    super.onInit();
  }

  getUserInfo() {
    if (user != null) {
      userDoc.doc(user!.phoneNumber).get().then((doc) {
        name.value =
            doc[DbDocs.fieldFirstName] + " " + doc[DbDocs.fieldLastName];
        if (doc.data()!.containsKey(DbDocs.fieldEmiratesId)) {
          emarites.value = doc[DbDocs.fieldEmiratesId];
        } else {
          emarites.value = "";
        }
        if (doc.data()!.containsKey(DbDocs.fieldImageUrl)) {
          imagePath.value = doc[DbDocs.fieldImageUrl];
          //logger.d(doc[DbDocs.fieldImageUrl]);
        } else {
          imagePath.value = "";
        }
      });
    }
  }
  getUserData()async {
    String? jsonData = await SharedPrefs().generalGetData(key: "user_data");
    if (jsonData != null) {
      final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
      print(updateUserProfileModel!.data!.appsUserFirstName!);
      print(updateUserProfileModel.data!.appsUserLastName!);
    }
  }
}
