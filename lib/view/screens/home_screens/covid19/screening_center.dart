import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/controller/vaccination_appionment_controller.dart';
import 'package:somerian_health/view/screens/home_screens/covid19/screening_date.dart';

import '../../../../controller/covid19_appionment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../../model/common_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
import '../vaccination/vaccination_date.dart';

class ScreeningCenterScreen extends StatelessWidget {
  const ScreeningCenterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controller =
        Get.put(VaccinationAppointmentController(context: context));
    _controller.getUserInfo(context);
    return Scaffold(
      appBar: CommonToolbar(title: "Covid-19 Screening"),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            height: 60.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    //  controller: searchController,
                    onChanged: (value) {
                      _controller.name.value = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.search, color: Properties.colorTextBlue),
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
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _controller
                    .collectionRef(
                        DbCollections.collectionCovidScreeningVaccination)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final _isSelected =
                            _controller.selectedIndex.contains(index);
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Obx(() {
                          if (_controller.name.value.isEmpty) {
                            return InkWell(
                              onTap: () {
                                _controller.selectedCenter = BasicModel(
                                    name: documentSnapshot['name'],
                                    uid: documentSnapshot.id);
                                _controller.locationController.text =
                                    documentSnapshot['name'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaccinationDate(
                                      controller: _controller,
                                      title: 'Covid-19 Appointment',
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: TextWidget(
                                      value: documentSnapshot['name'],
                                      textColor: Properties.colorTextBlue,
                                      size: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            );
                          } else if (documentSnapshot['name']
                              .toString()
                              .toLowerCase()
                              .contains(_controller.name.value.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                _controller.selectedCenter = BasicModel(
                                    name: documentSnapshot['name'],
                                    uid: documentSnapshot.id);
                                _controller.locationController.text =
                                    documentSnapshot['name'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaccinationDate(
                                      controller: _controller,
                                      title: 'Covid-19 Appointment',
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: TextWidget(
                                      value: documentSnapshot['name'],
                                      textColor: Properties.colorTextBlue,
                                      size: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        });
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
