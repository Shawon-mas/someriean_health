import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/view/screens/home_screens/covid19/screening_date.dart';
import 'package:somerian_health/view/screens/home_screens/visa/residency_visa.dart';

import '../../../../controller/covid19_appionment_controller.dart';
import '../../../../controller/vaccination_appionment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../../model/common_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
import '../vaccination/vaccination_date.dart';
import 'corporate_visa.dart';
import 'occupational_visa.dart';

class VisaScreeningCenterScreen extends StatelessWidget {
  const VisaScreeningCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _vaccination = FirebaseFirestore.instance
        .collection(DbCollections.collectionVisaScreeningVaccination);

    final _controller =
        Get.put(VaccinationAppointmentController(context: context));
 //   _controller.getUserInfo(context);
    List<String> name=['Residency Visa screening','Occupational Health Screening','Corporate Group Screening'];
    List<String> image=[
      'https://www.alhabbaidkh.ae/wp-content/uploads/2021/03/i9a8702-1012x675-1.jpg',
      'https://pr1.nicelocal.ae/e3xVFDu7aXBd-FbyPVoqFA/1120x700,q85/4px-BW84_n0QJGVPszge3NRBsKw-2VcOifrJIjPYFYkOtaCZxxXQ2fzk64ooXsXRtGCqY7U-oOgj1xnla0neF511oK6hU3fyiat3EZpcisll2ctSKvH-EA',
      'https://www.alhabbaidkh.ae/wp-content/uploads/2021/03/i9a8702-1012x675-1.jpg',
      ]
    ;

    return Scaffold(
      appBar: CommonToolbar(title: "Select Your Services"),
      body: ListView.builder(
        itemCount: image.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              if(index==0){
                Get.to(()=>ResidencyVisa(title: name[index],));
              }else if(index==1){
                Get.to(()=>OccupationalVisa(title: name[index],));
              }else{
                Get.to(()=>CorporateVisa(title: name[index],));

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140.h,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.network(
                      image[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.8), colorBlendMode: BlendMode.modulate,
                    ),

                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 40.h,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: TextWidget(
                              value: name[index],
                              size: 18.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white60,
                                    Properties.primaryColor,
                                  ])),
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}

/*
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
                      setState(() {
                        name = value;
                      });
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
                stream: _vaccination.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          if (name.isEmpty) {
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
                                        builder: (context) => SCreeningDate(
                                              controller: _controller,
                                              title: documentSnapshot['name'],
                                            )));
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
                              .contains(name.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                _controller.locationController.text =
                                    documentSnapshot['name'];
                                _controller.selectedCenter = BasicModel(
                                    name: documentSnapshot['name'],
                                    uid: documentSnapshot.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SCreeningDate(
                                            controller: _controller,
                                            title: documentSnapshot['name'])));
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
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
 */