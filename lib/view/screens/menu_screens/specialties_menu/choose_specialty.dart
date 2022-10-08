import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../../global/db_paths.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import 'doctors_list.dart';

class ChooseSpecialty extends StatefulWidget {
  const ChooseSpecialty({Key? key}) : super(key: key);

  @override
  State<ChooseSpecialty> createState() => _ChooseSpecialtyState();
}

class _ChooseSpecialtyState extends State<ChooseSpecialty> {
  final CollectionReference _doctors=FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Specialties'),
      body: Column(
        children: [
          CustomContainer(value: "Choose Specialty"),
          Expanded(
            child: StreamBuilder(
                stream: _doctors.snapshots(),
                builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          final DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                          return InkWell(
                            onTap: (){
                              //DoctorsList
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsList(speciality: documentSnapshot['title'],)));

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Properties.primaryColor,
                                ),
                                width: double.maxFinite,
                                height: 50.h,

                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: TextWidget(
                                    value: documentSnapshot['title'],
                                    size: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
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
/*
Column(
                              children: [

                             /*   Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(documentSnapshot['image'],height:100,width: 100,fit: BoxFit.cover,),
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
                                ),*/

                                Divider(
                                  color: Colors.black54,
                                )
                              ],
                            ),
 */
