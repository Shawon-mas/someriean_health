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

class MyReports extends StatelessWidget {
final String title;
   MyReports({Key? key, required this.title}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final CollectionReference _reports =
    FirebaseFirestore.instance.collection(DbCollections.collectionReport);
    return Scaffold(
      appBar: CommonToolbar(title: title),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: _reports
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                          return Image.network(documentSnapshot['image']);
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
