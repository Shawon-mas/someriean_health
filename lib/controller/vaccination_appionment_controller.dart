import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/view/screens/home_screens/vaccination/completed_vaccination_screen.dart';

import '../global/db_paths.dart';
import '../model/common_model.dart';

class VaccinationAppointmentController extends GetxController {
  final BuildContext context;
  var selectedDate = DateTime.now().obs;
  var passportIssueDate = DateTime.now().obs;
  var passportExpirationDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var valueChoose = "".obs;
  var valueNationality = "".obs;
  final gender = ['Male', 'Female', 'Others'];
  final paymentMethods = ['Cash on Board', 'RazorPay', 'Paypal'];
  final nationality = ['Afghan', 'Albanian', 'Emirati', 'Bangladeshi'];
  var isUploading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var genderController = TextEditingController();
  var nationalityController = TextEditingController();
  var timeAndDateController = TextEditingController();
  var emailController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var locationController = TextEditingController();
  var unifiedController = TextEditingController();
  var passportController = TextEditingController();
  var passportIssueController = TextEditingController();
  var passportExpirationController = TextEditingController();
  var emiratesController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  var selectedCenter = BasicModel(name: "", uid: "");
  var name = "".obs;
  List selectedIndex = [];
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  VaccinationAppointmentController({
    required this.context,
  });
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
  }

  passportDate(BuildContext context, DateTime dateTime,
      TextEditingController textEditingController) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    dateTime = picked!;
    textEditingController.text =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
  }

  getUserInfo(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var number = currentUser.phoneNumber;
      if (number != null) {
        patients.doc(number).get().then((value) {
          if (value.exists) {
            firstNameController.text = value[DbDocs.fieldFirstName];
            lastNameController.text = value[DbDocs.fieldLastName];
            mobileController.text = number;
            emailController.text = value[DbDocs.fieldEmail];
            genderController.text = value[DbDocs.fieldGender];
            nationalityController.text = value[DbDocs.fieldNationality];
            selectedTime.value = TimeOfDay.fromDateTime(DateTime.now());
            timeController.text = selectedTime.value.format(context).toString();
            dateController.text =
                '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
            passportIssueController.text =
                '${passportIssueDate.value.day}/${passportIssueDate.value.month}/${passportIssueDate.value.year}';
            passportExpirationController.text =
                '${passportExpirationDate.value.day}/${passportExpirationDate.value.month}/${passportExpirationDate.value.year}';
          }
        });
      }
    }
  }

  saveCovid(
      VaccinationAppointmentController controller, String collectionName, BuildContext context) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(selectedCenter.uid)
        .collection(DbCollections.collectionOrderedVaccination)
        .doc()
        .set({
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldTime: selectedTime.value.format(context).toString(),
      DbDocs.fieldDateEpoch:
          selectedDate.value.millisecondsSinceEpoch.toString(),
      DbDocs.fieldDate:
          '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
      DbDocs.fieldLocation: locationController.text,
      DbDocs.fieldPassport: passportController.text,
      DbDocs.fieldUnified: unifiedController.text,
      DbDocs.fieldPassportExpiration: passportExpirationController.text,
      DbDocs.fieldPassportIssue: passportIssueController.text,
      DbDocs.fieldEmiratesId: emiratesController.text,
    }).then((value) {
      successSnackBar(context, "Appointed Successfully");
      selectedDate.value = DateTime.now();
      selectedTime.value = TimeOfDay.fromDateTime(DateTime.now());
      passportExpirationDate.value = DateTime.now();
      passportIssueDate.value = DateTime.now();
      unifiedController.clear();
      passportController.clear();
      passportExpirationController.clear();
      passportIssueController.clear();
      emiratesController.clear();
      Get.back();
      Get.back();
      Get.off(() => CompletedVaccinationScreen(controller: controller));
    });
  }

  saveVaccination(VaccinationAppointmentController controller, BuildContext context) {
    FirebaseFirestore.instance
        .collection(DbCollections.collectionVaccination)
        .doc(selectedCenter.uid)
        .collection(DbCollections.collectionOrderedVaccination)
        .doc()
        .set({
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldTime: selectedTime.value.format(context).toString(),
      DbDocs.fieldDateEpoch:
          selectedDate.value.millisecondsSinceEpoch.toString(),
      DbDocs.fieldDate:
          '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
      DbDocs.fieldLocation: locationController.text,
    }).then((value) {
      successSnackBar(context, "Vaccination Appointed Successfully");
      selectedDate.value = DateTime.now();
      selectedTime.value = TimeOfDay.fromDateTime(DateTime.now());
      Get.back();
      Get.back();
      Get.back();
      Get.off(() => CompletedVaccinationScreen(controller: controller));
    });
  }

  CollectionReference collectionRef(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  @override
  void onInit() {
    getUserInfo(context);
    super.onInit();
  }
}
