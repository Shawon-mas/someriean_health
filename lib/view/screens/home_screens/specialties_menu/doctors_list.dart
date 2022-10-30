import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/db_paths.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../../model/selected_doctor_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../doctors_menu_screens/time_date.dart';

class DoctorsList extends StatefulWidget {
  final String speciality;
  final DoctorAppointmentController controller;
  const DoctorsList(
      {Key? key, required this.speciality, required this.controller})
      : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final CollectionReference _doctors =
      FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);

  var doctors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: _doctors
                    .where('title', isEqualTo: widget.speciality)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
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
                                    widget.controller.selectedDoctor =
                                        SelectedDoctorModel(
                                      uid: documentSnapshot.id,
                                      name: documentSnapshot['name'],
                                      image: documentSnapshot['image'],
                                      location: documentSnapshot['location'],
                                      title: documentSnapshot['title'],
                                      serviceProvider: ServiceProvider.Doctor,
                                    );
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
                        });
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
