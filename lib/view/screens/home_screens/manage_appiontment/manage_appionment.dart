import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
class ManageAppiontment extends StatefulWidget {
  const ManageAppiontment({Key? key}) : super(key: key);

  @override
  State<ManageAppiontment> createState() => _ManageAppiontmentState();
}

class _ManageAppiontmentState extends State<ManageAppiontment> {
  final CollectionReference _doctors =
  FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Appointment List '),
      body: Column(
        children: [
          Expanded(

                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {

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
                                       "https://demo.tagdiv.com/newspaper_health/wp-content/uploads/2015/08/37.jpg",
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
                                          value: "Dr. Yousef Ali",
                                          size: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          textColor: Properties.fontColor,
                                        ),
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: 'General Practitioner',
                                          size: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Properties.fontColor,
                                        ),
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: 'Somerian Clinic - Abu Dhabi',
                                          size: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Properties.fontColor,
                                        ),
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: 'Date: 12 August 2020',
                                          size: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Properties.fontColor,
                                        ),
                                        TextWidget(
                                          edgeInsetsGeometry: EdgeInsets.zero,
                                          value: 'Time: 11:00 AM',
                                          size: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Properties.fontColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                AppointmentButton(
                                  onPressed: ()
                                  {

                                  },
                                  value: 'Cancel Appointment',
                                ),
                                Divider(
                                  color: Colors.black54,
                                )
                              ],
                            ),
                          );
                        })

          )
        ],
      ),

    );
  }
}
