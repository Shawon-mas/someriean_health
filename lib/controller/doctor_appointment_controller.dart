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
import '../model/locationResponseModel.dart';
import '../model/specialistResponseModel.dart';
import '../routes/routes.dart';
import '../utilites/api_services.dart';
import '../view/screens/home_screens/doctors_menu_screens/complete_appointment_screen.dart';
import '../view/widget/general_button.dart';
import 'package:http/http.dart' as http;

class DoctorAppointmentController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var valueChoose = "".obs;
  var valuePayment = "".obs;
  var valueAppointment = "".obs;
  var valueNationality = "".obs;
  final gender = ['Male', 'Female', 'Others'];
  final paymentMethods = ['Cash on Board', 'RazorPay', 'Paypal'];
  final appointmentType = ['Book for Self', 'Book for Others'];
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
  var emiratesController = TextEditingController();

  var relationController = TextEditingController();
  var numberController = TextEditingController();
  var fullNameController = TextEditingController();
  var othersEmiratesIdController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;

  var locations = <LocationDatum?>[].obs;
  var selectedLocation = "".obs;

  var speciality = <Datum?>[].obs;
  var selectedSpeciality = "".obs;

  var selectedDoctor = SelectedDoctorModel(uid: "", name: "", image: "", location: "", title: "", serviceProvider: ServiceProvider.Doctor);
  var selectedFile = "Attachment (previous report file if available)".obs;
  var isProcessing = false.obs;

  final CollectionReference doctors = FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients = FirebaseFirestore.instance.collection(DbCollections.collectionPatients);

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(context: context, initialDate: DateTime(DateTime.now().year), firstDate: DateTime(1950, 8), lastDate: DateTime(2101));
    selectedDate.value = picked!;
  }

  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
  }

  _getSpecialist() async{
    final _response = await http.get(Uri.parse(ApiServices.SPECIALIST_URL),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
     // isSliderLoaded.value = true;
      final specialistModel = specialistResponseModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(specialistModel!=null){
        if(specialistModel.status!){
          speciality.value = specialistModel.data!;
        }
      }
    }
  }

  _getLocation() async{
    final _response = await http.get(Uri.parse(ApiServices.LOCATION_URL),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      // isSliderLoaded.value = true;
      final locationModel = locationResponseModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(locationModel!=null){
        if(locationModel.status!){
          locations.value = locationModel.data!;
        }
      }
    }
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
      required String emirates,
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
      DbDocs.fieldEmiratesId: emirates,
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
            emiratesController.text = value[DbDocs.fieldEmiratesId];
            nationalityController.text = value[DbDocs.fieldNationality];
          }
        });
      }
    }
  }

  proceedDialog(BuildContext context, DoctorAppointmentController controller) {
    Get.defaultDialog(
      title: 'Confirmation',
      barrierDismissible: true,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Obx(
                () => DropdownButton(
                  hint: const Text('Select Payment Method'),
                  isExpanded: true,
                  value: valuePayment.value == "" ? null : valuePayment.value,
                  underline: const SizedBox(),
                  onChanged: (newValue) {
                    valuePayment.value = newValue as String;
                  },
                  items: paymentMethods.map((valuItem) {
                    return DropdownMenuItem(
                      value: valuItem,
                      child: Text(valuItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                dense: false,
                contentPadding: EdgeInsets.zero,
                leading: IconButton(
                  icon: Icon(Icons.attach_file_outlined),
                  onPressed: () {
                    filePicker();
                  },
                ),
                title: Obx(
                  () => Text(
                    basename(selectedFile.value),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: messageController,
              enabled: true,
              decoration: InputDecoration(
                helperText: 'Message',
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 50, 0, 50),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
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
                      if (valuePayment.value != "Cash on Board") {
                        infoSnackBar(context, "Coming Soon");
                      } else {
                        proceedPayment(context, controller);
                        //test();
                      }
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

  test() {
    logger.d(selectedDoctor.serviceProvider.name);
  }

  proceedPayment(BuildContext context, DoctorAppointmentController controller) async {
    isProcessing.value = true;
    var doc = FirebaseFirestore.instance.collection(DbCollections.collectionAppointments).doc();
    doc.set({
      DbDocs.fieldDoctorId: selectedDoctor.uid,
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldMessage: messageController.text,
      DbDocs.fieldOtherNumber: numberController.text,
      DbDocs.fieldServiceProvider: selectedDoctor.serviceProvider.name,
      DbDocs.fieldFile:'',
      DbDocs.fieldPaymentMethod:'',
      DbDocs.fieldTime: selectedTime.value.format(context).toString(),
      DbDocs.fieldDateEpoch: selectedDate.value.millisecondsSinceEpoch.toString(),
      DbDocs.fieldDate: '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
    }).then((value) async {
      if (selectedFile.value != "Attachment (previous report file if available)") {
        final storageRef = FirebaseStorage.instance.ref();
        final fileRef = storageRef.child(doc.id + "/" + basename(selectedFile.value));
        final uploadTask = await fileRef.putFile(File(selectedFile.value));
        String url = await uploadTask.ref.getDownloadURL();
        FirebaseFirestore.instance.collection(DbCollections.collectionAppointments).doc(doc.id).set({
          DbDocs.fieldFile: url,
        }, SetOptions(merge: true));
      }
      /* Setting appointment for doctor or nurse according to service providers*/
      FirebaseFirestore.instance
          .collection(serviceProvider(selectedDoctor.serviceProvider.name))
          .doc(selectedDoctor.uid)
          .collection(DbCollections.collectionAppointments)
          .doc(doc.id)
          .set({DbDocs.fieldAppointmentId: doc.id}, SetOptions(merge: true));
      /* Setting appointment for patient */
      FirebaseFirestore.instance
          .collection(DbCollections.collectionPatients)
          .doc(mobileController.text)
          .collection(DbCollections.collectionAppointments)
          .doc(doc.id)
          .set({DbDocs.fieldAppointmentId: doc.id}, SetOptions(merge: true));
      String number = mobileController.text.substring(4);
      String message =
          "Dear ${firstNameController.text} ${lastNameController.text}, confirmed your appointment with ${selectedDoctor.name}(${selectedDoctor.title}) Date: ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year} Place: ${selectedDoctor.location} Time: ${selectedTime.value.format(context).toString()}";
      String url = "http://www.mshastra.com/sendurlcomma.aspx?user=20099446&pwd=Achcc@1234&senderid=AD-SOMERIAN&CountryCode=+971&mobileno=$number&msgtext=$message&smstype=0";
      http.get(Uri.parse(url)).then((value) {
        logger.d(value.body);
      });
      successSnackBar(context, "Appointment booked");
    });
    isProcessing.value = false;
    Get.back();
    Get.back();
    Get.back();
    Get.off(() => CompleteAppointmentScreen(controller: controller));
  }
  proceedOthersPayment(BuildContext context, DoctorAppointmentController controller) async {
    isProcessing.value = true;
    var doc = FirebaseFirestore.instance.collection(DbCollections.collectionAppointments).doc();
    doc.set({
      DbDocs.fieldDoctorId: selectedDoctor.uid,
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldRelationship: relationController.text,
      DbDocs.fieldOtherNumber: numberController.text,
      DbDocs.fieldOthersName: fullNameController.text,
      DbDocs.fieldOthersEmiratesId: othersEmiratesIdController.text,
      DbDocs.fieldServiceProvider: selectedDoctor.serviceProvider.name,
      DbDocs.fieldAppointsType: 'Book for others',
      DbDocs.fieldTime: selectedTime.value.format(context).toString(),
      DbDocs.fieldDateEpoch: selectedDate.value.millisecondsSinceEpoch.toString(),
      DbDocs.fieldDate: '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
    }).then((value) async {
      if (selectedFile.value != "Attachment (previous report file if available)") {
        final storageRef = FirebaseStorage.instance.ref();
        final fileRef = storageRef.child(doc.id + "/" + basename(selectedFile.value));
        final uploadTask = await fileRef.putFile(File(selectedFile.value));
        String url = await uploadTask.ref.getDownloadURL();
        FirebaseFirestore.instance.collection(DbCollections.collectionAppointments).doc(doc.id).set({
          DbDocs.fieldFile: url,
        }, SetOptions(merge: true));
      }
      /* Setting appointment for doctor or nurse according to service providers*/
      FirebaseFirestore.instance
          .collection(serviceProvider(selectedDoctor.serviceProvider.name))
          .doc(selectedDoctor.uid)
          .collection(DbCollections.collectionAppointments)
          .doc(doc.id)
          .set({DbDocs.fieldAppointmentId: doc.id}, SetOptions(merge: true));
      /* Setting appointment for patient */
      FirebaseFirestore.instance
          .collection(DbCollections.collectionPatients)
          .doc(mobileController.text)
          .collection(DbCollections.collectionAppointments)
          .doc(doc.id)
          .set({DbDocs.fieldAppointmentId: doc.id}, SetOptions(merge: true));
      String number = mobileController.text.substring(4);
      String message =
          "Dear ${firstNameController.text} ${lastNameController.text}, confirmed your appointment with ${selectedDoctor.name}(${selectedDoctor.title}) Date: ${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year} Place: ${selectedDoctor.location} Time: ${selectedTime.value.format(context).toString()}";
      String url = "http://www.mshastra.com/sendurlcomma.aspx?user=20099446&pwd=Achcc@1234&senderid=AD-SOMERIAN&CountryCode=+971&mobileno=$number&msgtext=$message&smstype=0";
      http.get(Uri.parse(url)).then((value) {
        logger.d(value.body);
      });
      successSnackBar(context, "Appointment booked");
    });
    isProcessing.value = false;
    Get.back();
    Get.back();
    Get.back();
    Get.off(() => CompleteAppointmentScreen(controller: controller));
  }

  String serviceProvider(String data) {
    switch (data) {
      case "Doctor":
        return DbCollections.collectionDoctors;
      case "Nurse":
        return DbCollections.collectionNurse;
      default:
        return DbCollections.collectionDoctors;
    }
  }

  @override
  void onInit() {
    getUserInfo();
    _getSpecialist();
    _getLocation();
    super.onInit();
  }
}
