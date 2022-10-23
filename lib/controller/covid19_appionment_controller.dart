
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/db_paths.dart';
import '../model/common_model.dart';

class Covid19AppointmentController extends GetxController{
  final BuildContext context;
  var selectedDate = DateTime.now().obs;
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
  var currentUser = FirebaseAuth.instance.currentUser;
  var selectedCenter=BasicModel(name: "");
  final CollectionReference doctors =
  FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients =
  FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  Covid19AppointmentController(
      {required this.context,
       });
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
  }

  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
  }


  getUserInfo() {
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
            timeController.text = selectedTime.value.format(context).toString();
            dateController.text =
            '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
          }
        });
      }
    }
  }

}