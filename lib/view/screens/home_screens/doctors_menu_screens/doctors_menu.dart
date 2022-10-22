import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import 'package:somerian_health/view/screens/home_screens/doctors_menu_screens/time_date.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class DoctorsMenuScreen extends StatefulWidget {
  DoctorsMenuScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsMenuScreen> createState() => _DoctorsMenuScreenState();
}

class _DoctorsMenuScreenState extends State<DoctorsMenuScreen> {
  final _controller = Get.put(DoctorAppointmentController());
  String name="";

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: StreamBuilder(
        stream: _controller.doctors.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            for (var data in snapshot.data!.docs) {
              _controller.locations.value.add(data['location']);
              _controller.speciality.value.add(data['title']);
            }
            _controller.locations.value =
                _controller.locations.toSet().toList(); //Remove duplicate items
            _controller.speciality.value =
                _controller.speciality.toSet().toList();
            /* _controller.selectedLocation.value =
                _controller.locations.first; //Taking first value
            _controller.selectedSpeciality.value = _controller.speciality.first; */
          }
          return snapshot.hasData
              ? Column(
                  children: [
                    Container(
                      color: Colors.grey,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Obx(
                                      () => DropdownButton(
                                        hint: Text('Location'),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        value: _controller
                                                    .selectedLocation.value ==
                                                ""
                                            ? null
                                            : _controller
                                                .selectedLocation.value,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items:
                                            _controller.locations.map((items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
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
                                  width: 10.h,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Obx(
                                      () => DropdownButton(
                                        hint: Text('Specialty'),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        value: _controller.selectedSpeciality.value == ""
                                            ? null
                                            : _controller.selectedSpeciality.value,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items:
                                            _controller.speciality.map((items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
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
                                    setState(()
                                  {
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
                                        fontSize: 18.sp,
                                        color: Properties.colorTextBlue),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.white))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          String location = documentSnapshot['location'];
                          String speciality = documentSnapshot['title'];
                          if (name.isEmpty) {
                            return Obx(
                              () => (_controller.selectedLocation.value == "" &&
                                      _controller.selectedSpeciality.value ==
                                          "")
                                  ? doctorsList(documentSnapshot, context)
                                  : Visibility(
                                      visible:
                                          _controller.selectedLocation.value ==
                                                  location &&
                                              _controller.selectedSpeciality
                                                      .value ==
                                                  speciality,
                                      child: doctorsList(
                                          documentSnapshot, context),
                                    ),
                            );
                          } else if (documentSnapshot['name'].toString().toLowerCase().contains(name.toLowerCase()) ||documentSnapshot['location'].toString().toLowerCase().contains(name.toLowerCase()) ) {
                            return Obx(
                              () => (_controller.selectedLocation.value == "" && _controller.selectedSpeciality.value == "")
                                  ? doctorsList(documentSnapshot, context)
                                  : Visibility(
                                      visible:
                                          _controller.selectedLocation.value ==
                                                  location &&
                                              _controller.selectedSpeciality
                                                      .value ==
                                                  speciality,
                                      child: doctorsList(
                                          documentSnapshot, context),
                                    ),
                            );
                          } else {
                            return Container(

                            );
                          }
                        },
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget doctorsList(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                documentSnapshot['image'],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    value: documentSnapshot['name'],
                    size: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Properties.fontColor,
                  ),
                  TextWidget(
                    value: documentSnapshot['title'],
                    size: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Properties.fontColor,
                  ),
                  TextWidget(
                    value: documentSnapshot['location'],
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
              _controller.selectedDoctor = SelectedDoctorModel(
                  uid: documentSnapshot.id,
                  name: documentSnapshot['name'],
                  image: documentSnapshot['image'],
                  location: documentSnapshot['location'],
                  title: documentSnapshot['title']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeDateScreen(
                    controller: _controller,
                  ),
                ),
              );
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
