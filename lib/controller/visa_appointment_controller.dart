
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../global/global_constants.dart';
import '../model/user/update_user_profile_model.dart';
import '../model/visaEmiratesResponseModel.dart';
import '../model/visaPackagesResponseModel.dart';
import '../model/visaScreeningLocationModel.dart';
import '../utilites/api_services.dart';
import '../utilites/response_repository.dart';
import '../utilites/shared_prefs.dart';
import '../view/screens/bottombar_screen.dart';

class VisaScreeningController extends GetxController{

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var selectGender = "".obs;
  final gender = ['Male', 'Female', 'Others'];

  var selectPayment = "".obs;
  final paymentMethods = ['Pay Online','Pay at CHSC'];

  var selectVisaTypes=''.obs;
  final visaTypes= ['New','Renewal','Typing Centre New','Typing Centre Renewal'];
  var selectVisaScreeningTypes=''.obs;
  final visaScreeningTypes= ['Pre-Employment'];


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
  var c_nameController = TextEditingController();
  var c_representativeNameController = TextEditingController();
  var c_numberOfPeopleController = TextEditingController();

  var visaPackageList = <VisaPackagesList?>[].obs;
  var visaPackageName=''.obs;
  var visaPackageId=''.obs;

  var visaEmiratesList = <VisaEmiratesList?>[].obs;
  var visaEmiratesName=''.obs;
  var visaEmiratesId=''.obs;

  var visaLocationList = <VisaLocation?>[].obs;
  var visaLocationName=''.obs;
  var visaLocationId=''.obs;

  var isProcessing = false.obs;
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101),
        helpText: 'Select Appointment Date');
    selectedDate.value = picked!;
  }
  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
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
      nationalityController.text =DateFormat("yyyy-MM-dd").format(updateUserProfileModel.data!.appsUserDob!).toString();
      emiratesController.text = updateUserProfileModel.data!.appsUserEmiratesIdNumber!;
    }
  }

  _getVisaEmirates() async{
    final _response = await http.get(Uri.parse(ApiServices.VISA_SCREENING_EMIRATES),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      final visaEmiratesModel = visaEmiratesResponseModelFromJson(_response.body);
      if(visaEmiratesModel!=null){
        if(visaEmiratesModel.status!){
          visaEmiratesList.value = visaEmiratesModel.data!;
          print('true');
        }
      }else{

      }
    }
  }
  _getVisaPackages() async{
    final _response = await http.get(Uri.parse(ApiServices.VISA_SCREENING_PACKAGES),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      final visaPackagesModel = visaPackagesResponseModelFromJson(_response.body);
      if(visaPackagesModel!=null){
        if(visaPackagesModel.status!){
          visaPackageList.value = visaPackagesModel.data!;
          print('true');
        }
      }else{

      }
    }
  }
  _getLocations() async{
    final _response = await http.get(Uri.parse(ApiServices.VISA_SCREENING_LOCATIONS),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      final visaLocationModel = visaScreeningLocationModelFromJson(_response.body);
      if(visaLocationModel!=null){
        if(visaLocationModel.status!){
          visaLocationList.value = visaLocationModel.data!;
          print('true');
        }
      }else{

      }
    }
  }

  getEmirates(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Your Emirates'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: visaEmiratesList.length,
                itemBuilder: (BuildContext context, int index) {
                  List<VisaEmiratesList?> getEmirates=visaEmiratesList;
                  return ListTile(
                    title: Text(getEmirates[index]!.visaScreeningEmirateName!),
                    onTap: () {
                      visaEmiratesName.value=getEmirates[index]!.visaScreeningEmirateName!;
                      visaEmiratesId.value=getEmirates[index]!.visaScreeningEmirateId!.toString();
                      print(visaEmiratesId.value);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
  getPackages(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Your Packages'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: visaPackageList.length,
                itemBuilder: (BuildContext context, int index) {
                  List<VisaPackagesList?> getVisa=visaPackageList;
                  return ListTile(
                    title: Text(getVisa[index]!.visaScreeningPackageName!+'-'+'AED'+getVisa[index]!.visaScreeningPackagePrice!),
                    onTap: () {
                      visaPackageName.value=getVisa[index]!.visaScreeningPackageName!+'-'+'AED'+getVisa[index]!.visaScreeningPackagePrice!;
                      visaPackageId.value=getVisa[index]!.visaScreeningPackageId!.toString();
                      print(visaPackageId.value);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
  getLocation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Your Location'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: visaLocationList.length,
                itemBuilder: (BuildContext context, int index) {
                  List<VisaLocation?> getLocation=visaLocationList;
                  return ListTile(
                    title: Text(getLocation[index]!.visaScreeningLocationName!),
                    onTap: () {
                      visaLocationName.value=getLocation[index]!.visaScreeningLocationName!;
                      visaLocationId.value=getLocation[index]!.visaScreeningLocationId!.toString();
                      print(visaLocationId.value);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  bookResidencyVisa(BuildContext context) async{
    isProcessing.value = true;
    var bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    //'${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.
    // day}'
    var bookingTime=selectedTime.value.format(context).toString();
   /* print(bookingDate);
    print('Package Id:${selectedPackage.id}');
    print('Hospital Location Id:${selectedLocationId.value}');*/

    Map<String, dynamic> body = {
      ApiKeyName.VISA_SCREENING_APP_USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.VISA_SCREENING_TYPES_ID: 1.toString(),
      ApiKeyName.VISA_SCREENING_EMIRATES_ID: visaEmiratesId.value,
      ApiKeyName.VISA_SCREENING_PACKAGES_ID: visaPackageId.value,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_DATE: bookingDate,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_TIME: bookingTime,
      ApiKeyName.VISA_SCREENING_APP_USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_LAST_NAME: lastNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_PHONE_NUMBER: mobileController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_GENDER: genderController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_EMAIL: emailController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_DOB: nationalityController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_ADDRESS: messageController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_VISA_TYPE: selectVisaTypes.value,
      ApiKeyName.VISA_SCREENING_APP_USER_PAYMENT_TYPE: selectPayment.value,

    };
    print(await SharedPrefs().getUserId());
    var response = await authPost(url: ApiServices.RESIDENCY_VISA_SCREENING_BOOKINGS, body: body);
    if(response!=null) {
      try{
          successSnackBar(context, 'Your Residency Visa Booking Done');
          Get.to(()=>BottomBarScreen());
          isProcessing.value = false;
          print(response.body);

      }catch(e){
        print(e.toString());
        isProcessing.value = false;
      }

    }else{

    }
  }
  bookOccupationalVisa(BuildContext context) async{
    isProcessing.value = true;
    var bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    //'${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.
    // day}'
    var bookingTime=selectedTime.value.format(context).toString();
    /* print(bookingDate);
    print('Package Id:${selectedPackage.id}');
    print('Hospital Location Id:${selectedLocationId.value}');*/

    Map<String, dynamic> body = {
      ApiKeyName.VISA_SCREENING_APP_USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.VISA_SCREENING_TYPES_ID: 2.toString(),
      ApiKeyName.VISA_SCREENING_LOCATION: visaLocationId.value,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_DATE: bookingDate,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_TIME: bookingTime,
      ApiKeyName.VISA_SCREENING_APP_USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_LAST_NAME: lastNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_PHONE_NUMBER: mobileController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_GENDER: genderController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_EMAIL: emailController.text,
      ApiKeyName.occVISA_SCREENING_TYPES: selectVisaScreeningTypes.value,
      ApiKeyName.VISA_SCREENING_APP_USER_PAYMENT_TYPE: selectPayment.value,

    };
    print(await SharedPrefs().getUserId());
    var response = await authPost(url: ApiServices.RESIDENCY_VISA_SCREENING_BOOKINGS, body: body);
    if(response!=null) {
      try{
        successSnackBar(context, 'Your Occupational Health Booking Done');
        Get.to(()=>BottomBarScreen());
        isProcessing.value = false;
        print(response.body);

      }catch(e){
        print(e.toString());
        isProcessing.value = false;
      }

    }else{

    }
  }
  bookCorporateVisa(BuildContext context) async{
    isProcessing.value = true;
    var bookingDate = DateFormat("yyyy-MM-dd").format(selectedDate.value).toString();
    //'${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.
    // day}'
    var bookingTime=selectedTime.value.format(context).toString();
    /* print(bookingDate);
    print('Package Id:${selectedPackage.id}');
    print('Hospital Location Id:${selectedLocationId.value}');*/

    Map<String, dynamic> body = {
      ApiKeyName.VISA_SCREENING_APP_USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.VISA_SCREENING_TYPES_ID: 3.toString(),
      ApiKeyName.VISA_SCREENING_LOCATION: visaLocationId.value,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_DATE: bookingDate,
      ApiKeyName.VISA_SCREENING_APP_USER_BOOKING_TIME: bookingTime,
      ApiKeyName.VISA_SCREENING_APP_USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_LAST_NAME: lastNameController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_PHONE_NUMBER: mobileController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_GENDER: genderController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_EMAIL: emailController.text,
      ApiKeyName.corVISA_SCREENING_COMPANY_NAME: c_nameController.text,
      ApiKeyName.corVISA_SCREENING_COMPANY_REPRESENTATIVE_NAME: c_representativeNameController.text,
      ApiKeyName.corVISA_SCREENING_COMPANY_NOP: c_numberOfPeopleController.text,
      ApiKeyName.VISA_SCREENING_APP_USER_PAYMENT_TYPE: selectPayment.value,

    };
    print(await SharedPrefs().getUserId());
    var response = await authPost(url: ApiServices.RESIDENCY_VISA_SCREENING_BOOKINGS, body: body);
    if(response!=null) {
      try{
        successSnackBar(context, 'Your Corporate Group Screening Booking Done');
        Get.to(()=>BottomBarScreen());
        isProcessing.value = false;
        print(response.body);

      }catch(e){
        print(e.toString());
        isProcessing.value = false;
      }

    }else{

    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getUserData();
    _getVisaPackages();
    _getVisaEmirates();
    _getLocations();
    super.onInit();
  }

}