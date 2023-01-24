import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import 'package:path/path.dart';
import 'package:somerian_health/view/screens/bottombar_screen.dart';
import '../model/healthPackageBookingResponseModel.dart';
import '../model/healthPackageListResponseModel.dart';
import '../model/locationResponseModel.dart';
import '../model/selected_health_package.dart';
import '../model/user/update_user_profile_model.dart';
import '../routes/routes.dart';
import '../utilites/api_services.dart';
import '../utilites/response_repository.dart';
import '../utilites/shared_prefs.dart';
import '../view/screens/home_screens/doctors_menu_screens/complete_appointment_screen.dart';
import '../view/screens/home_screens/health_packages/complete_healthcare_screen.dart';
import '../view/widget/general_button.dart';
import 'package:http/http.dart' as http;

class HealthcareController extends GetxController {

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

  var bookForWhom=''.obs;

  var selectedPackage=SelectedHealthPackageModel(
    name: '',image: '',title: '',id: '',price: '',details: ''
  );

  var currentUser = FirebaseAuth.instance.currentUser;

  var selectedFile = "Attachment (previous report file if available)".obs;
  var isProcessing = false.obs;
  var healthPackageList = <HealthPackageDatum?>[].obs;
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients =
      FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  var isDataFetch = false.obs;
  var locations = <LocationDatum?>[].obs;

  var selectedLocation = "".obs;
  var selectedLocationId=''.obs;
  var selectedLocationName=''.obs;

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

  _getUserData()async{
    String? jsonData = await SharedPrefs().generalGetData(key:"user_data");
    if (jsonData != null) {
      final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
      firstNameController.text = updateUserProfileModel!.data!.appsUserFirstName!;
      lastNameController.text = updateUserProfileModel.data!.appsUserLastName!;
      mobileController.text = updateUserProfileModel.data!.appsUserMobileNumber!;
      emailController.text = updateUserProfileModel.data!.appsUserEmail!;
      genderController.text = updateUserProfileModel.data!.appsUserGender!;
      nationalityController.text = updateUserProfileModel.data!.appsUserNationality!;

    }
  }
  _getHealthPackage() async{
    final _response = await http.get(Uri.parse(ApiServices.ALL_ACTIVE_HEALTH_PACKAGE),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      // isSliderLoaded.value = true;
      final healthPackageListResponseModel = healthPackageListResponseModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(healthPackageListResponseModel.status!=null && healthPackageListResponseModel.data!=null){
        healthPackageList.value=healthPackageListResponseModel.data!;
        isDataFetch.value=true;
        print(_response.body);

      }else{

      }
    }
    /*var response = await generalGet(url: ApiServices.ALL_ACTIVE_HEALTH_PACKAGE);
    if(response!=null) {
      try{
        final healthPackageListResponseModel = healthPackageListResponseModelFromJson(response.body);
        if(healthPackageListResponseModel.status!=null && healthPackageListResponseModel.data!=null){
          healthPackageList.value=healthPackageListResponseModel.data!;
          isDataFetch.value=true;
          print(response.body);

        }else{

        }

      }catch(e){
        print(e.toString());
      }

    }else{
      //  isProcessing.value = false;

    }*/
  }
  bookedHealthPackage(BuildContext context) async{
    isProcessing.value = true;
    var bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    //'${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.
    // day}'
    var bookingTime=selectedTime.value.format(context).toString();
    print(bookingDate);
    print('Package Id:${selectedPackage.id}');
    print('Hospital Location Id:${selectedLocationId.value}');

    Map<String, dynamic> body = {
      ApiKeyName.HEALTH_PACKAGE_USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.HEALTH_PACKAGE_ID: selectedPackage.id,
      ApiKeyName.HOSPITAL_LOCATION_ID: selectedLocationId.value,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_DATE: bookingDate,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_TIME: bookingTime,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_LAST_NAME: lastNameController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_NUMBER: mobileController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_GENDER: genderController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_EMAIL: emailController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_USER_NATIONALITY: nationalityController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_MESSAGE: messageController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_PRICE: selectedPackage.price,

      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_WHOM: bookForWhom.value,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_PAYMENT_METHOD: valuePayment.value,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_COMPANY_NAME: c_nameController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_COMPANY_NUMBER: c_numberController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_COMPANY_EMAIL: c_emailController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_COMPANY_AUTH_PERSON: c_personController.text,
      ApiKeyName.HEALTH_PACKAGE_BOOKING_FOR_COMPANY_ADDRESS: c_addressController.text,
    };
    print(await SharedPrefs().getUserId());
    var response = await authPost(url: ApiServices.HEALTH_PACKAGE_BOOKING, body: body);
    if(response!=null) {
      try{
          final packageBookingResponseModel=healthPackageBookingResponseModelFromJson(response.body);
          if (packageBookingResponseModel!.status! && packageBookingResponseModel.data != null){
            successSnackBar(context, 'Your Health Package Booking Done');
            Get.to(()=>BottomBarScreen());
            isProcessing.value = false;
            print(response.body);
          }else{

          }


      }catch(e){
        print(e.toString());
        isProcessing.value = false;
      }

    }else{

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
  getLocationList(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Hospital Location'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  List<LocationDatum?> getLocationName=locations;
                  return ListTile(
                    title: Text(getLocationName[index]!.hospitalLocationName!),
                    onTap: () {
                      selectedLocationName.value=getLocationName[index]!.hospitalLocationName!;
                      selectedLocationId.value=getLocationName[index]!.hospitalLocationId!.toString();
                      Navigator.pop(context);
                      print(selectedLocationId.value);
                    },
                  );
                },
              ),
            ),
          );
        });
  }


  @override
  void onInit() {
    //getUserInfo();
    _getHealthPackage();
    _getUserData();
    _getLocation();
    super.onInit();
  }
}
/*
/*  getUserInfo() {
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
  }*/

  filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = result.files.single.path!;
    }
  }

  /*proceedPayment(BuildContext context, HealthcareController controller) async {
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
  }*/
 */