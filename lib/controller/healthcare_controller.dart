import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import 'package:path/path.dart';
import '../routes/routes.dart';
import '../view/screens/home_screens/doctors_menu_screens/complete_appointment_screen.dart';
import '../view/screens/home_screens/health_packages/complete_healthcare_screen.dart';
import '../view/widget/general_button.dart';
import 'package:http/http.dart' as http;

class HealthcareController extends GetxController {
  final BuildContext context;
  final String price;
  final String uid;
  final String healthcareId;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var valueChoose = "".obs;
  var valuePayment = "".obs;
  var valueNationality = "".obs;
  var valueAppointment = "".obs;
  final gender = ['Male', 'Female', 'Others'];
  final paymentMethods = ['Cash on Board'];
  final appointmentType = ['Book for Self', 'Book for Company'];
  final nationality = ['Afghan', 'Albanian', 'Emirati', 'Bangladeshi'];
  var isUploading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var genderController = TextEditingController();
  var nationalityController = TextEditingController();
  var emailController = TextEditingController();
  var passportController = TextEditingController();
  var timeAndDateController = TextEditingController();
  var messageController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var c_nameController = TextEditingController();
  var c_numberController = TextEditingController();
  var c_emailController = TextEditingController();
  var c_personController = TextEditingController();
  var c_addressController = TextEditingController();
  var c_employeesController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;
  var locations = <String>[].obs;
  var selectedLocation = "".obs;
  var selectedFile = "Attachment (previous report file if available)".obs;
  var isProcessing = false.obs;

  final CollectionReference doctors =
      FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);

  HealthcareController(
      {required this.context,
      required this.price,
      required this.uid,
      required this.healthcareId});

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
    dateController.text =
        '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
  }

  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    selectedTime.value = picked!;
    timeController.text = selectedTime.value.format(context).toString();
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
      Get.offAllNamed(bottom);
    }).onError((error, stackTrace) {
      isUploading.value = false;
      errorSnackBar(context, "Something went wrong");
    });
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

  proceedDialog(BuildContext context, HealthcareController controller) {
    Get.defaultDialog(
      title: 'Confirmation',
      barrierDismissible: true,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              //leading: Text("AED"),
              subtitle: Text("Price"),
              title: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  "AED " + price,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: messageController,
                enabled: true,
                decoration: InputDecoration(
                  helperText: 'Message',
                  hintText: "Message (Optional)",
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 50, 0, 50),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => AppointmentButton(
                    isLoading: isProcessing.value,
                    onPressed: () {
                      proceedPayment(context, controller);
                    },
                    value: 'Proceed',
                  )),
            ),
          ],
        ),
      ),
    );
  }

  filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = result.files.single.path!;
    }
  }

  proceedPayment(BuildContext context, HealthcareController controller) async {
    isProcessing.value = true;
    await FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(mobileController.text)
        .collection(DbCollections.collectionHealthcare)
        .doc()
        .set({
      DbDocs.fieldHealthcareId: healthcareId,
      DbDocs.fieldHealthcarePackageListId: uid,
      DbDocs.fieldTime: selectedTime.value.format(context).toString(),
      DbDocs.fieldDateEpoch:
          selectedDate.value.millisecondsSinceEpoch.toString(),
      DbDocs.fieldDate:
          '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
      DbDocs.fieldMessage: messageController.text,
      DbDocs.fieldClinicLocation: selectedLocation.value,
      DbDocs.fieldHealthcarePrice: price,
    }).then((value) {
      String number = mobileController.text.substring(4);
      String message =
          "Dear ${firstNameController.text} ${lastNameController.text}, we are confirmed your health package  Date: ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year} Place: ${controller.selectedLocation.value} Time: ${selectedTime.value.format(context).toString()}";
      String url = "http://www.mshastra.com/sendurlcomma.aspx?user=20099446&pwd=Achcc@1234&senderid=AD-SOMERIAN&CountryCode=+971&mobileno=$number&msgtext=$message&smstype=0";
      http.get(Uri.parse(url)).then((value) {
        logger.d(value.body);
      });
      isProcessing.value = false;
      Get.back();
      Get.off(
        () => CompleteHealthcareScreen(
          controller: controller,
        ),
      );
    });
    //Get.to(() => CompleteAppointmentScreen(controller: controller));
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }
}
