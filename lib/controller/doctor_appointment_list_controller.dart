
import 'dart:convert';

import 'package:get/get.dart';
import '../model/appointmentListResponseModel.dart';
import '../model/healthPackageBookingListResponseModel.dart';
import '../model/visaScreeningBookingListModel.dart';
import '../utilites/api_services.dart';
import '../utilites/response_repository.dart';
import '../utilites/shared_prefs.dart';

class DoctorAppointmentListController extends GetxController{
  var dataFetch=false.obs;
 // var dataPackageFetch=false.obs;
  var selectIndex = 0.obs;
  var selectStatus = 0.obs;
  var allAppointment = <AppointmentListDatum?>[].obs;
  var packageAppointmentList = <HealthPackageBookingList?>[].obs;
  var visaAppointmentList = <VisaBookingList?>[].obs;
  List<String> list = ["Pending", "Confirmed"];

   _getAllAppointment() async{

     Map<String, dynamic> body = {
       ApiKeyName.DOCTOR_APPOINTMENT_APPS_USER_ID: await SharedPrefs().getUserId(),
     };
     var response = await authPost(url: ApiServices.DOCTOR_APPOINTMENT_LIST_URL, body: body);
     if(response!=null)
     {
       //  print(response.body);
       try{
         final appointmentListResponseModel = appointmentListResponseModelFromJson(response.body);
         if (appointmentListResponseModel!.status! && appointmentListResponseModel.data != null){
            allAppointment.value=appointmentListResponseModel.data!;
            dataFetch.value=true;
       //    Get.off(() => CompleteAppointmentScreen(controller: controller));
           print(response.body);
         }
         else
         {
        //   dataFetch.value=false;
         }

       }catch(e){
         print(e.toString());
       //  dataFetch.value=false;
       }

     }else{
     //  dataFetch.value=true;
       //dataFetch.value=true;
     }


   }
   _getHealthPackageBookingList() async{
     Map<String, dynamic> body = {
       ApiKeyName.HEALTH_PACKAGE_USER_ID: await SharedPrefs().getUserId(),
     };
     var response = await authPost(url: ApiServices.HEALTH_PACKAGE_BOOKING_LIST, body: body);
     if(response!=null)
     {
       //  print(response.body);
       try{
         final healthPackageBookingList = healthPackageBookingListResponseModelFromJson(response.body);
         if (healthPackageBookingList!.status! && healthPackageBookingList.data != null){
           packageAppointmentList.value=healthPackageBookingList.data!;
           dataFetch.value=true;
           //    Get.off(() => CompleteAppointmentScreen(controller: controller));
           print(response.body);
         }
         else
         {
           //   dataFetch.value=false;
         }

       }catch(e){
         print(e.toString());
         //  dataFetch.value=false;
       }

     }else{
       //  dataFetch.value=true;
       //dataFetch.value=true;
     }
   }
  _getVisaBookingList() async{
    Map<String, dynamic> body = {
      ApiKeyName.VISA_SCREENING_APP_USER_ID: await SharedPrefs().getUserId(),
    };
    var response = await authPost(url: ApiServices.GET_VISA_SCREENING_BOOKINGS, body: body);
    if(response!=null)
    {
      //  print(response.body);
      try{

        final visaScreeningBookingListModel = visaScreeningBookingListModelFromJson(response.body);
        if (visaScreeningBookingListModel!.status!){
          visaAppointmentList.value=visaScreeningBookingListModel.data!;
        //  dataFetch.value=true;
          //    Get.off(() => CompleteAppointmentScreen(controller: controller));
          print(response.body);
        }
        else
        {
          //   dataFetch.value=false;
        }

      }catch(e){
        print(e.toString());
        //  dataFetch.value=false;
      }

    }else{
      //  dataFetch.value=true;
      //dataFetch.value=true;
    }
  }

/*
final visaScreeningBookingList = visaScreeningBookingListModelFromJson(response.body);
        if (visaScreeningBookingList.status! && visaScreeningBookingList.data != null){
          visaAppointmentList.value=visaScreeningBookingList.data!;
        //  dataFetch.value=true;
          //    Get.off(() => CompleteAppointmentScreen(controller: controller));
          print(response.body);
        }
        else
        {
          //   dataFetch.value=false;
        }
 */
@override
  void onInit() {
    // TODO: implement onInit
  //_getAllAppointment();
 // _getHealthPackageBookingList();
 // getVisaBookingList();
  _getVisaBookingList();
    super.onInit();
  }
}