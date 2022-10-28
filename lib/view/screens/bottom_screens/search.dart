import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/covid19_appionment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/general_button.dart';
import '../../widget/primary_toolbar.dart';
import '../../widget/text_widget.dart';

class Search extends StatefulWidget {

  const Search({Key? key, }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name="";
  final CollectionReference _doctors =FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  @override
  Widget build(BuildContext context) {


    final _controller = Get.put(Covid19AppointmentController(context: context));

    return Scaffold(
      appBar:  PrimaryToolbar(),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 60.h,
            width: double.infinity,
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Container(
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
                ),
              ),
            ),),
          Expanded(
            child: StreamBuilder(
                stream: _doctors
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                          if(name.isEmpty){
                            return Container();
                          } else if (documentSnapshot['name'].toString().toLowerCase().contains(name.toLowerCase()) ||documentSnapshot['location'].toString().toLowerCase().contains(name.toLowerCase()) ){

                            return doctorsList(
                                documentSnapshot, context);
                          }else {
                            return Container(
                            );
                          }

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
              /*  _controller.selectedDoctor = SelectedDoctorModel(
                  uid: documentSnapshot.id,
                  name: documentSnapshot['name'],
                  image: documentSnapshot['image'],
                  location: documentSnapshot['location'],
                  title: documentSnapshot['title']);*/
              /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeDateScreen(
                    controller: _controller,
                  ),
                ),
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
