import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/model/selected_doctor_model.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../model/specialistResponseModel.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
import 'doctors_list.dart';

class ChooseSpecialty extends StatefulWidget {

  ChooseSpecialty({Key? key}) : super(key: key);

  @override
  State<ChooseSpecialty> createState() => _ChooseSpecialtyState();
}

class _ChooseSpecialtyState extends State<ChooseSpecialty> {
  final _controller = Get.put(DoctorAppointmentController());
  final CollectionReference _doctors =
      FirebaseFirestore.instance.collection(DbCollections.collectionDoctors);
  final List selectedIndexs = [];
  int selectionStatus=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Specialties'),
      body: Column(
        children: [
          CustomContainer(value: "Find a Doctor by Speciality"),
           Obx(() => _controller.isSpecialityLoaded.value==true
               ?Expanded(
                 child: ListView.builder(
                 itemCount: _controller.speciality.length,
                 itemBuilder: (context, index){
                   List<Datum?> specialityData = _controller.speciality;
                   return Obx(() => InkWell(
                     onTap: () {
                       //DoctorsList
                       _controller.specialitiesId.value=specialityData[index]!.doctorSpecialitiesId!.toString();
                       Get.to(()=>DoctorsBySpecialities(speciality: specialityData[index]!.doctorSpecialitiesId!.toString(),controller: _controller,));
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
                             value: specialityData[index]!.doctorSpecialitiesName!,
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
