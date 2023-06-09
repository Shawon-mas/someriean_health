import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/db_paths.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../../model/doctorByHospitalResponseModel.dart';
import '../../../../model/doctorBySpecialistResponseModel.dart';
import '../../../../model/locationResponseModel.dart';
import '../../../../model/selected_doctor_model.dart';
import '../../../../utilites/api_services.dart';
import '../../../../utilites/response_repository.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../doctors_menu_screens/time_date.dart';

class DoctorsByLocation extends StatefulWidget {
  final String location;
  final DoctorAppointmentController controller;
  const DoctorsByLocation(
      {Key? key, required this.location, required this.controller})
      : super(key: key);

  @override
  State<DoctorsByLocation> createState() => _DoctorsByLocation();
}

class _DoctorsByLocation extends State<DoctorsByLocation> {
  final CollectionReference _doctors =
  FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  List<DoctorByHospital?> doctorByLocationData=[];
  bool isLoading = false;

  var doctors;
  _getDoctorByLocation() async{
    Map<String, dynamic> body = {
      ApiKeyName.DOCTOR_BY_LOCATION: widget.location,
    };
    var response = await authPost(url: ApiServices.HOSPITAL_BY_DOCTOR_PROFILE_URL, body: body);
    if(response!=null)
    {
      //  print(response.body);
      try{
        final doctorByHospital = doctorByHospitalResponseModelFromJson(response.body);
        if (doctorByHospital!.status! && doctorByHospital.data != null){
          setState(() {
            doctorByLocationData.addAll(doctorByHospital.data!);
            isLoading = true;
          });
          // doctorBySpecialitiesIdList.value=doctorBySpecialistResponseModel.data!;
          // dataFetch.value=true;
          //    Get.off(() => CompleteAppointmentScreen(controller: controller));
          print(response.body);
        }
        else
        {
          setState(() {
            isLoading = false;
          });
        }

      }catch(e){
        print(e.toString());
        // dataFetch.value=false;
        setState(() {
          isLoading = false;
        });
      }

    }else{
      //  isProcessing.value = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDoctorByLocation();
    //   doctorBySpecialitiesIdListData = widget.controller.doctorBySpecialitiesIdList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [

          isLoading?
          Expanded(

            child: ListView.builder(

                itemCount: doctorByLocationData.length,
                itemBuilder: (context, index) {
                  // List<SpecialistiesDatum?> doctorBySpecialitiesIdListData=widget.controller.doctorBySpecialitiesIdList;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              child: Image.network(
                                ApiServices.IMAGE_BASE_URL+doctorByLocationData[index]!.doctorProfileImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctorByLocationData[index]!.doctorProfileName!,
                                  size: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctorByLocationData[index]!.doctorProfileSpecialitiesName!,
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctorByLocationData[index]!.doctorProfileHospitalLocationName!,
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                              ],
                            )
                          ],
                        ),
                        AppointmentButton(
                          onPressed: () {
                            widget.controller.selectedDoctor =
                                SelectedDoctorModel(
                                  uid: doctorByLocationData[index]!.doctorProfileId!.toString(),
                                  name: doctorByLocationData[index]!.doctorProfileName!,
                                  image:ApiServices.IMAGE_BASE_URL+doctorByLocationData[index]!.doctorProfileImage!,
                                  location: doctorByLocationData[index]!.doctorProfileHospitalLocationName!,
                                  title: doctorByLocationData[index]!.doctorProfileSpecialitiesName!,
                                );

                            Get.to(()=>TimeDateScreen(controller: widget.controller));

                               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TimeDateScreen(
                                      controller: widget.controller,
                                    )));
                          },
                          value: 'Book an Appointment',
                        ),
                        Divider(
                          color: Colors.black54,
                        )
                      ],
                    ),
                  );
                }),
          )
              :Center(child: CircularProgressIndicator(),)



        ],
      ),
    );
  }
}
