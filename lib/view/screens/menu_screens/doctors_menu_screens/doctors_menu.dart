import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import 'package:somerian_health/view/screens/menu_screens/doctors_menu_screens/time_date.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class DoctorsMenuScreen extends StatelessWidget {
  final _controller = Get.put(DoctorAppointmentController());
  DoctorsMenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            _controller.selectedLocation.value =
                _controller.locations.first; //Taking first value
            _controller.selectedSpeciality.value = _controller.speciality.first;
          }
          return snapshot.hasData
              ? Column(
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 100.h,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),

                              child: Obx(
                                () => DropdownButton(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  value: _controller.selectedLocation.value==""?null:_controller.selectedLocation.value,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: _controller.locations.map((items) {
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                              child: Obx(
                                () => DropdownButton(
                                  underline: const SizedBox(),
                                  isExpanded: true,
                                  value: _controller.selectedSpeciality.value,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: _controller.speciality.map((items) {
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
                          return Obx(
                            () => Visibility(
                              visible: _controller.selectedLocation.value ==
                                      location &&
                                  _controller.selectedSpeciality.value ==
                                      speciality,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          documentSnapshot['image'],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              value:
                                                  documentSnapshot['location'],
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
                                        _controller.selectedDoctor =
                                            SelectedDoctorModel(
                                                uid: documentSnapshot.id,
                                                name: documentSnapshot['name'],
                                                image:
                                                    documentSnapshot['image'],
                                                location: documentSnapshot[
                                                    'location'],
                                                title:
                                                    documentSnapshot['title']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TimeDateScreen(
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
                              ),
                            ),
                          );
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
}
