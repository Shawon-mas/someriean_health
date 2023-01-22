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
import 'package:somerian_health/view/screens/home_screens/doctors_menu_screens/doctors_list.dart';
import '../model/doctorAppointmentResponseModel.dart';
import '../model/doctorBySpecialistResponseModel.dart';
import '../model/doctorResponseModel.dart';
import '../model/doctorTimeSlotResponseModel.dart';
import '../model/locationResponseModel.dart';
import '../model/specialistResponseModel.dart';
import '../model/user/update_user_profile_model.dart';
import '../routes/routes.dart';
import '../utilites/api_services.dart';
import '../utilites/response_repository.dart';
import '../utilites/shared_prefs.dart';
import '../view/screens/home_screens/doctors_menu_screens/complete_appointment_screen.dart';
import '../view/widget/general_button.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DoctorAppointmentController extends GetxController {
  var name = "".obs;
  var isSelf="".obs;
  var tap=false.obs;
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
  var isSpecialityLoaded = false.obs;

  var speciality = <Datum?>[].obs;
  var specialitiesId = "".obs;

  var doctorBySpecialitiesIdList = <SpecialistiesDatum?>[].obs;
  var selectedSpeciality = "".obs;
  var isHospitalLoaded = false.obs;

  var doctorList = <DoctorData?>[].obs;

  var timeSlotList = <TimeSlotDatum?>[].obs;
  var selectedTimeSlot="".obs;
  var isTimeSlotLoaded=true.obs;

  var selectedDoctor = SelectedDoctorModel(uid: "", name: "", image: "", location: "", title: "", serviceProvider: ServiceProvider.Doctor);
  var selectedFile = "Attachment (previous report file if available)".obs;
  var isProcessing = false.obs;

  final CollectionReference doctors = FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final CollectionReference patients = FirebaseFirestore.instance.collection(DbCollections.collectionPatients);
  var dataFetch=false.obs;

  var timeId=''.obs;

  selectDate(BuildContext context) async {
    isTimeSlotLoaded.value=false;
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101),
        helpText: 'Select Appointment Date');
    if(picked==null)
    {
      isTimeSlotLoaded.value=true;
      return;
    }
      selectedDate.value = picked;
    getDoctorTimeSlot(context,DateFormat("yyyy-MM-dd").format(selectedDate.value).toString());
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

      final specialistModel = specialistResponseModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(specialistModel!=null){
        if(specialistModel.status!){
          isSpecialityLoaded.value = true;
          speciality.value = specialistModel.data!;
          /*for(var data in specialistModel.data!){
            specialitiesId.value=data!.doctorSpecialitiesId!.toString();
          }*/

          print('true');
        }
      }else{

      }
    }
  }
  getDoctorBySpecialistId() async{
    Map<String, dynamic> body = {
      ApiKeyName.DOCTOR_BY_SPECIALIST: specialitiesId.value,
    };
    var response = await authPost(url: ApiServices.DOCTOR_BY_SPECIALIST_URL, body: body);
    if(response!=null)
    {
      //  print(response.body);
      try{
        final doctorBySpecialistResponseModel = doctorBySpecialistResponseModelFromJson(response.body);
        if (doctorBySpecialistResponseModel!.status! && doctorBySpecialistResponseModel.data != null){
          doctorBySpecialitiesIdList.value=doctorBySpecialistResponseModel.data!;
         // dataFetch.value=true;
          //    Get.off(() => CompleteAppointmentScreen(controller: controller));
          print(response.body);
        }
        else
        {
          dataFetch.value=false;
        }

      }catch(e){
        print(e.toString());
        dataFetch.value=false;
      }

    }else{
      //  isProcessing.value = false;
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
          isHospitalLoaded.value = true;
          locations.value = locationModel.data!;
        }
      }
    }
  }
  _getDoctorList() async{
    final _response = await http.get(Uri.parse(ApiServices.DOCTOR_PROFILE_URL),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      // isSliderLoaded.value = true;
      final doctorListModel = doctorResponseModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(doctorListModel!=null){
        if(doctorListModel.status!){
          dataFetch.value=true;
          doctorList.value = doctorListModel.data!;
        }
      }
    }
  }
  getDoctorTimeSlot(BuildContext context,selectDate) async{
   // var selectDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();

    Map<String, dynamic> body = {
      ApiKeyName.DOCTOR_PROFILE_ID: selectedDoctor.uid,
      ApiKeyName.DOCTOR_DATE_SLOT: selectDate,
    };
    var response = await authPost(url: ApiServices.DOCTOR_APPOINTMENT_SLOT_TIME, body: body);
    isTimeSlotLoaded.value=true;
    if(response!=null) {
      try{
        final doctorTimeSlotResponseModel = doctorTimeSlotResponseModelFromJson(response.body);
        if(doctorTimeSlotResponseModel.status!=null && doctorTimeSlotResponseModel.data!=null){
          timeSlotList.value=doctorTimeSlotResponseModel.data!;
        //  print(response.body);
          print(timeSlotList.length);

         // infoSnackBar(context, 'Time Slot Found');
          if(timeSlotList.isNotEmpty){
            infoSnackBar(context, 'Time Slot Found');
          }else{
            infoSnackBar(context, 'No Time Slot Found');
          }
        }else{
          infoSnackBar(context, 'No Time Slot Found');
        }

      }catch(e){
        print(e.toString());

      }

    }else{
    //  isProcessing.value = false;
      infoSnackBar(context, 'No Time Slot Found');
    }

  }
  bookedDoctorAppointment(BuildContext context,DoctorAppointmentController controller) async{
    isProcessing.value = true;
    var bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    //'${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}'
    var bookingTime=selectedTime.value.format(context).toString();
    print(bookingDate);

    Map<String, dynamic> body = {
      ApiKeyName.DOCTOR_APPOINTMENT_APPS_USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.DOCTOR_PROFILE_ID: selectedDoctor.uid,
      ApiKeyName.DOCTOR_APPOINTMENT_PREFER_DATE: bookingDate,
      ApiKeyName.DOCTOR_APPOINTMENT_PREFER_TIME: selectedTimeSlot.value,
      ApiKeyName.DOCTOR_TIME_SLOT_ID: timeId.value,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_LAST_NAME: lastNameController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_MOBILE_NUMBER: mobileController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_GENDER: genderController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_EMIRATES_ID: emiratesController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_USER_NATIONALITY: nationalityController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_BOOK_IS_SELF: isSelf.value,
      ApiKeyName.DOCTOR_APPOINTMENT_OTHERS_USER_FULL_NAME: fullNameController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_OTHERS_USER_EMIRATES_ID: othersEmiratesIdController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_OTHERS_USER_RELATIONSHIP: relationController.text,
      ApiKeyName.DOCTOR_APPOINTMENT_OTHERS_USER_MOBILE_NUMBER: numberController.text,
  };
    print(await SharedPrefs().getUserId());
    var response = await authPost(url: ApiServices.DOCTOR_APPOINTMENT_URL, body: body);
    if(response!=null) {
     try{
       final doctorAppointmentResponseModel = doctorAppointmentResponseModelFromJson(response.body);
       if (doctorAppointmentResponseModel!.status! && doctorAppointmentResponseModel.data != null){
         Get.off(() => CompleteAppointmentScreen(controller: controller));
         print(response.body);
         isProcessing.value = false;
       }
       else
       {

       }

     }catch(e){
     print(e.toString());
      isProcessing.value = false;
     }

    }else{

    }

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
      emiratesController.text = updateUserProfileModel.data!.appsUserEmiratesIdNumber!;
    }
  }


  getTimeSlot(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Slot'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: timeSlotList.length,
                itemBuilder: (BuildContext context, int index) {
                  List<TimeSlotDatum?> getSlot=timeSlotList;
                  return ListTile(
                    title: Text(getSlot[index]!.doctorSlotTime!),
                    onTap: () {
                      selectedTimeSlot.value=getSlot[index]!.doctorSlotTime!;
                      timeId.value=getSlot[index]!.doctorTimeSlotId!.toString();
                      print(getSlot[index]!.doctorTimeSlotId!.toString());
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        });
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
    logger.d(selectedDoctor.serviceProvider!.name);
  }

  proceedPayment(BuildContext context, DoctorAppointmentController controller) async {
    isProcessing.value = true;
    var doc = FirebaseFirestore.instance.collection(DbCollections.collectionAppointments).doc();
    doc.set({
      DbDocs.fieldDoctorId: selectedDoctor.uid,
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldMessage: messageController.text,
      DbDocs.fieldOtherNumber: numberController.text,
      DbDocs.fieldServiceProvider: selectedDoctor.serviceProvider!.name,
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
          .collection(serviceProvider(selectedDoctor.serviceProvider!.name))
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
   // Get.off(() => CompleteAppointmentScreen(controller: controller));
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
      DbDocs.fieldServiceProvider: selectedDoctor.serviceProvider!.name,
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
          .collection(serviceProvider(selectedDoctor.serviceProvider!.name))
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
   // Get.off(() => CompleteAppointmentScreen(controller: controller));
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
    _getUserData();
    _getDoctorList();
    _getSpecialist();
    _getLocation();
    super.onInit();
  }
}
