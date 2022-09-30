import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/menu_screens/doctors_menu_screens/time_date.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
class DoctorsMenuScreen extends StatefulWidget {
  const DoctorsMenuScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsMenuScreen> createState() => _DoctorsMenuScreenState();
}

class _DoctorsMenuScreenState extends State<DoctorsMenuScreen> {
  final CollectionReference _doctors=FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
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
          SizedBox(height: 10.h,),
          Expanded(
            child: StreamBuilder(
              stream: _doctors.snapshots(),
                builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        final DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
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
                              ),
                              AppointmentButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeDateScreen()));
                                },
                                value:'Book an Appointment' ,
                              ),
                              Divider(
                               color: Colors.black54,
                              )
                            ],
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
ListTile(
                            title: Text(documentSnapshot['name']),subtitle:Text(documentSnapshot['title']) ,
                          )
 */
