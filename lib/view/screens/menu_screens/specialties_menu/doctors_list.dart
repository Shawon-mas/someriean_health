import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../../services/query_doctors.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../doctors_menu_screens/time_date.dart';
class DoctorsList extends StatefulWidget {
  final String speciality;
  const DoctorsList({Key? key, required this.speciality}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final CollectionReference _doctors=FirebaseFirestore.instance.collection('doctors');

 var doctors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  QueryDoctors().getDoctors(widget.speciality)
    .then((QuerySnapshot docs){
      for(var doc in docs.docs){

        String name = doc.get('name');
        print(name);
      }
      *//*   doctors=docs.docs[0].data();
         print(doctors);*//*
    });*/



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
          Expanded(
            child: StreamBuilder(
                stream: _doctors.where('title',isEqualTo:widget.speciality).snapshots(),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeDateScreen(
                                      title: documentSnapshot['title'],image: documentSnapshot['image'],location: documentSnapshot['location'],name: documentSnapshot['name'],
                                    )));
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
