import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';

class MenuController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  var userDoc =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  var name = "".obs;

  @override
  void onInit() {
    if (user != null) {
      userDoc.doc(user!.phoneNumber).get().then((doc) {
        name.value = doc[DbDocs.fieldFirstName]+" "+doc[DbDocs.fieldLastName];
      });
    }
    super.onInit();
  }
}
