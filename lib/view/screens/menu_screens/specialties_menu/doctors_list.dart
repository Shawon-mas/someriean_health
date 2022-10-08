import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../services/query_doctors.dart';
import '../../../widget/common_toolbar.dart';
class DoctorsList extends StatefulWidget {
  final String speciality;
  const DoctorsList({Key? key, required this.speciality}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

 var doctors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    QueryDoctors().getDoctors(widget.speciality)
    .then((QuerySnapshot docs){
         doctors=docs.docs[0].data();
         print(doctors);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 100.h,
            width: double.infinity,
            child: Column(
              children: [

              ],
            ),
          ),

        ],
      ),

    );
  }
}
