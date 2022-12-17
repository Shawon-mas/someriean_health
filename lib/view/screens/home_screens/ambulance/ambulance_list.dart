import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/ambulance_controller.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../../model/selected_ambulance_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ambulance_book.dart';
class Ambulance_List extends StatelessWidget {
  final _controller = Get.put(AmbulanceController());
  final controllerDoc = Get.put(DoctorAppointmentController());
   Ambulance_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _ambulance =
    FirebaseFirestore.instance.collection(DbCollections.collectionAmbulance);

    return Scaffold(
      appBar: CommonToolbar(title: "Ambulance"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            value: 'Available Ambulance',
            textColor: Properties.colorTextBlue,
            size: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          Expanded(
            child: StreamBuilder(
                stream: _ambulance
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
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
                                        documentSnapshot['image'],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: documentSnapshot['name'],
                                          size: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          textColor: Properties.fontColor,
                                        ),
                                        SizedBox(height: 10,),
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: documentSnapshot['service'],
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

                                    //FlutterPhoneDirectCaller.callNumber('+085921191121');
                                    launch('tel://998');

                                  /*  _controller.selectedAmbulance=SelectedAmbulance(
                                      uid: documentSnapshot.id,
                                      name: documentSnapshot['name'],
                                      service: documentSnapshot['service'],
                                      image: documentSnapshot['image']
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AmbulanceBooking(
                                                  controller: _controller,
                                                  controllerDoc: controllerDoc,
                                                )));*/
                                   /* AmbulanceBooking
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
                                                )));*/
                                  },
                                  value: 'Call Ambulance',
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
