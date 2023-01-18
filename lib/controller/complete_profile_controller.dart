import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/utilites/response_repository.dart';
import 'package:somerian_health/view/screens/bottombar_screen.dart';

import '../model/user/update_user_profile_model.dart';
import '../routes/routes.dart';
import '../utilites/api_services.dart';
import '../utilites/shared_prefs.dart';
import 'package:http/http.dart' as http;

class CompleteProfileController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay(hour: 8, minute: 30).obs;
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

  var currentUser = FirebaseAuth.instance.currentUser;
  var locations = <String>[].obs;
  var selectedLocation = "".obs;
  var speciality = <String>[].obs;
  var selectedSpeciality = "".obs;

  var selectedCountry = "".obs;
  final CollectionReference doctors = FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101),
        helpText: 'Select Date of Birth');
    selectedDate.value = picked!;
  }

  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
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
    FirebaseFirestore.instance.collection(DbCollections.collectionPatients).doc(mobileNo).set({
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
      Get.offAllNamed(bottom);
    }).onError((error, stackTrace) {
      isUploading.value = false;
      errorSnackBar(context, "Something went wrong");
    });
  }

  checkFieldCheck(BuildContext context) {
    if (firstNameController.text.toString().isEmpty) {
      //getErrorSnack('First Name Required');
      errorSnackBar(context, "First Name Required");
    } else if (lastNameController.text.toString().isEmpty) {
      errorSnackBar(context, "Last Name Required");
    } else if (mobileController.text.toString().isEmpty) {
      errorSnackBar(context, "Mobile Number Required");
    } else if (emailController.text.toString().isEmpty) {
      errorSnackBar(context, "Email Required");
    } else if (valueChoose.value.isEmpty) {
      errorSnackBar(context, "Gender Required");
    } else if (selectedCountry.value=='') {
      errorSnackBar(context, "Country Required");
    } else if (passportController.text.toString().isEmpty) {
      errorSnackBar(context, "Emirates ID Required");
    } else {
      _submitProfileNew(context);
    }
  }

  submitProfile() async {
    var dob = '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}';

    Map<String, dynamic> body = {
      ApiKeyName.USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.USER_LAST_NAME: lastNameController.text,
      ApiKeyName.USER_DOB: dob,
      ApiKeyName.USER_EMAIL: emailController.text.toString(),
      ApiKeyName.USER_GENDER: valueChoose.value.toString(),
      ApiKeyName.USER_NATIONALITY: valueNationality.value,
      ApiKeyName.USER_EMIRATES_ID: passportController.text,
    };

    try {
      var response = await http.post(Uri.parse(ApiServices.USER_UPDATE_URL), body: body, headers: await ApiServices().headerWithToken());
      logger.d(ApiServices.USER_UPDATE_URL);
      logger.d(body);
      logger.d(await ApiServices().headerWithToken());
      logger.d(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Response:${response.body}");
        }
        Get.to(BottomBarScreen());
      }
    } catch (e) {
      logger.d(e);
      //  errorSnackBar(context, 'Something Went Wrong');
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  _submitProfileNew(context) async {
    isUploading.value = true;
    var dob = '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}';

    Map<String, dynamic> body = {
      ApiKeyName.USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.USER_LAST_NAME: lastNameController.text,
      ApiKeyName.USER_DOB: dob,
      ApiKeyName.USER_EMAIL: emailController.text.toString(),
      ApiKeyName.USER_GENDER: valueChoose.value.toString(),
      ApiKeyName.USER_NATIONALITY: selectedCountry.value,
      ApiKeyName.USER_EMIRATES_ID: passportController.text,
    };

    var response = await authPost(url: ApiServices.USER_UPDATE_URL, body: body);
    if (response != null) {
      try {
        final updateUserProfileModel = updateUserProfileModelFromJson(response.body);
        if (updateUserProfileModel!.status! && updateUserProfileModel.data != null) {

          /*Get all data*/
        //  await SharedPrefs().generalStoreData(value: response.body, key: "user_data");
          await SharedPrefs().isLogin(true);
          print(await SharedPrefs().getIsLogin());
         /* String? jsonData = await SharedPrefs().generalGetData(key: "user_data");
          if (jsonData != null) {
            final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
            print(updateUserProfileModel);

          }*/
          Get.offAll(BottomBarScreen());
          isUploading.value = false;
          successSnackBar(context, "Submitted successfully");
        }
        /*Do the rest*/
      } catch (e) {
        /*Handle error*/
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passportController.dispose();
  }
}
