import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../../model/doctorResponseModel.dart';
import '../../../../model/locationResponseModel.dart';
import '../../../../model/specialistResponseModel.dart';
import '../../../../utilites/api_services.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class DoctorList extends StatefulWidget {

  DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final _controller = Get.put(DoctorAppointmentController());
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            //height: 100.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Obx(
                            () => DropdownButton(
                              hint: Text('Location'),
                              isExpanded: true,
                              underline: const SizedBox(),
                              value: _controller.selectedLocation.value == ""
                                  ? null
                                  : _controller.selectedLocation.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _controller.locations.map((items) {
                                return DropdownMenuItem(
                                  value:
                                      items!.hospitalLocationName!.toString(),
                                  child: Text(
                                      items.hospitalLocationName!.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                _controller.selectedLocation.value =
                                    newValue as String;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Obx(
                            () => DropdownButton(
                              hint: Text('Specialty'),
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: _controller.selectedSpeciality.value == ""
                                  ? null
                                  : _controller.selectedSpeciality.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _controller.speciality.map((items) {
                                return DropdownMenuItem(
                                  value:
                                      items!.doctorSpecialitiesName!.toString(),
                                  child: Text(
                                      items.doctorSpecialitiesName!.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                _controller.selectedSpeciality.value =
                                    newValue as String;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextField(
                      //  controller: searchController,
                      onChanged: (value) {
                       // _controller.name = value as RxString;
                        setState(() {
                          name=value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search,
                              color: Properties.colorTextBlue),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontSize: 18.sp, color: Properties.colorTextBlue),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => _controller.dataFetch.value == true
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _controller.doctorList.length,
                      itemBuilder: (context, index) {
                        List<LocationDatum?> locationData =
                            _controller.locations;
                        String location =
                            locationData[index]!.hospitalLocationName!;

                        List<Datum?> specialityData = _controller.speciality;
                        String speciality = specialityData[index]!.doctorSpecialitiesName!;

                        List<DoctorData?> doctorListData = _controller.doctorList;

                        if(name.isEmpty){
                          return Obx(() => (_controller.selectedLocation.value ==
                              "" &&
                              _controller.selectedSpeciality.value == "")
                              ? doctorList(doctorListData[index], context)
                              : Visibility(
                              visible: _controller.selectedLocation.value ==
                                  location &&
                                  _controller.selectedSpeciality.value ==
                                      speciality,
                              child: doctorList(
                                  doctorListData[index], context)));
                        }else if(
                        doctorListData[index]!.doctorProfileName!.toString().toLowerCase().contains(name.toLowerCase()) ||
                            doctorListData[index]!.doctorProfileHospitalLocationName!.toString().toLowerCase().contains(name.toLowerCase())
                        ){
                          return Obx(() => (_controller.selectedLocation.value ==
                              "" &&
                              _controller.selectedSpeciality.value == "")
                              ? doctorList(doctorListData[index], context)
                              : Visibility(
                              visible: _controller.selectedLocation.value ==
                                  location &&
                                  _controller.selectedSpeciality.value ==
                                      speciality,
                              child: doctorList(
                                  doctorListData[index], context)));
                        }else{
                          return Container();
                        }


                      }))
              : Center(
                  child: CircularProgressIndicator(),
                )),
        ],
      ),
    );
  }

  Widget doctorList(DoctorData? doctorListData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  ApiServices.IMAGE_BASE_URL +
                      doctorListData!.doctorProfileImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    edgeInsetsGeometry: EdgeInsets.zero,
                    value: doctorListData.doctorProfileName!,
                    size: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Properties.fontColor,
                  ),
                  TextWidget(
                    edgeInsetsGeometry: EdgeInsets.zero,
                    value: doctorListData.doctorProfileSpecialitiesName!,
                    size: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Properties.fontColor,
                  ),
                  TextWidget(
                    edgeInsetsGeometry: EdgeInsets.zero,
                    value: doctorListData.doctorProfileHospitalLocationName!,
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
              /* _controller.selectedDoctor = SelectedDoctorModel(
                uid: documentSnapshot.id,
                name: documentSnapshot['name'],
                image: documentSnapshot['image'],
                location: documentSnapshot['location'],
                title: documentSnapshot['title'],
                serviceProvider: ServiceProvider.Doctor,
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => TimeDateScreen(controller: _controller,),),
              );*/
            },
            value: 'Book an Appointment',
          ),
          Divider(
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
