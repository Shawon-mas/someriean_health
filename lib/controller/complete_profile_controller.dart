import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';

import '../routes/routes.dart';

class CompleteProfileController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var valueChoose = "".obs;
  var valueNationality = "".obs;
  final gender = ['Male', 'Female', 'Others'];
  final nationality = ['Afghan', 'Albanian', 'Emirati', 'Bangladeshi'];
  var isUploading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passportController = TextEditingController();

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
  }

  storeValues(
      {required String firstName,
      required String lastName,
      required DateTime dob,
      required String mobileNo,
      required String email,
      required String gender,
      required String nationality,
      required String passport,
      required String uid,
      required BuildContext context}) {
    isUploading.value = true;
    FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(mobileNo)
        .set({
      DbDocs.fieldFirstName: firstName,
      DbDocs.fieldLastName: lastName,
      DbDocs.fieldDob: '${dob.day}/${dob.month}/${dob.year}',
      DbDocs.fieldDobMillSec: dob.microsecondsSinceEpoch.toString(),
      DbDocs.fieldNumber: mobileNo,
      DbDocs.fieldEmail: email,
      DbDocs.fieldGender: gender,
      DbDocs.fieldNationality: nationality,
      DbDocs.fieldPassport: passport,
      DbDocs.fieldUID: uid,
      //add fcm here
    }).then((value) {
      isUploading.value = false;
      successSnackBar(context, "Submitted successfully");
      Get.offAllNamed(home);
    }).onError((error, stackTrace) {
      isUploading.value = false;
      errorSnackBar(context, "Something went wrong");
    });
  }
}
