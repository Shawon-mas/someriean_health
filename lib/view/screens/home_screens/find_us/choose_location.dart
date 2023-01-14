import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../model/locationResponseModel.dart';
import '../../../../model/specialistResponseModel.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';


class ChooseLocation extends StatefulWidget {
  final String title;

  ChooseLocation({Key? key, required this.title}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final _controller = Get.put(DoctorAppointmentController());
  final List selectedIndexs = [];
  int selectionStatus=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: widget.title),
      body: Column(
        children: [
          CustomContainer(value: "Find a Doctor by Hospital Location"),
          Obx(() => _controller.isHospitalLoaded.value==true
              ?Expanded(
            child: ListView.builder(
                itemCount: _controller.locations.length,
                itemBuilder: (context, index){
                  List<LocationDatum?> locationData = _controller.locations;
                  return Obx(() => InkWell(
                    onTap: () {
                      //DoctorsList

                    //  Get.to(()=>DoctorsBySpecialities(speciality: specialityData[index]!.doctorSpecialitiesId!.toString(),controller: _controller,));
                      setState(() {
                        selectionStatus=index;
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.red, //                   <--- border color
                            width: 1.w,
                          ),
                          color:selectionStatus==index?Properties.primaryColor: Colors.white,
                        ),
                        width: double.maxFinite,
                        height: 50.h,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextWidget(
                            value: locationData[index]!.hospitalLocationName!,
                            size: 14.sp,
                            fontWeight: FontWeight.w500,
                            textColor:selectionStatus==index?Colors.white:Properties.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ));

                }
            ),
          )
              :Center(child: CircularProgressIndicator(),)
          )




          /*  Expanded(
            child: StreamBuilder(
                stream: _doctors.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<SelectedDoctorModel> doctors = [];
                    for (var data in snapshot.data!.docs) {
                      doctors.add(SelectedDoctorModel(
                          uid: data.id,
                          name: data['name'],
                          image: data['image'],
                          location: data['location'],
                          title: data['title'],
                          serviceProvider: ServiceProvider.Doctor,
                        ),
                      );
                    }
                    final ids = doctors.map((e) => e.title).toSet();
                    doctors.retainWhere((x) => ids.remove(x.title));
                    return ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          final _isSelected = selectedIndexs.contains(index);
                          return InkWell(
                            onTap: () {
                              //DoctorsList
                              setState(() {
                                 selectionStatus=index;

                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorsList(
                                    speciality:
                                    doctors[index].title,
                                    controller: widget._controller,
                                  ),
                                ),
                              );

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Colors.red, //                   <--- border color
                                    width: 1.w,
                                  ),
                                  color:selectionStatus==index?Properties.primaryColor: Colors.white,
                                ),
                                width: double.maxFinite,
                                height: 50.h,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: TextWidget(
                                    value: doctors[index].title,
                                    size: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    textColor:selectionStatus==index?Colors.white:Properties.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )*/
        ],
      ),
    );
  }
}

