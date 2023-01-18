import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../controller/doctor_appointment_list_controller.dart';
import '../../../../global/properties.dart';
import '../../../../model/appointmentListResponseModel.dart';
import '../../../../model/doctorResponseModel.dart';
import '../../../../utilites/api_services.dart';
import '../../../widget/text_widget.dart';

class DoctorAppointmentList extends StatelessWidget {
  final controller = Get.put(DoctorAppointmentListController());
  final _controller = Get.put(DoctorAppointmentController());
  DoctorAppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final  controller=Get.put(DoctorAppointmentListController());
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => controller.dataFetch.value == true
          ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.allAppointment.length,
              itemBuilder: (context, index) {
                List<AppointmentListDatum?> getAllAppointment =
                    controller.allAppointment;


                return Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Container(
                    //  height: 100.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              color: Colors.grey, //edited
                              spreadRadius: 1,
                              blurRadius: 2 //edited
                              ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    edgeInsetsGeometry: EdgeInsets.zero,
                                    value: getAllAppointment[index]!
                                        .doctorProfileName!,
                                    size: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: Properties.fontColor,
                                  ),
                                  TextWidget(
                                    edgeInsetsGeometry: EdgeInsets.zero,
                                    value: getAllAppointment[index]!
                                        .doctorProfileSpecialitiesName!,
                                    size: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    textColor: Properties.fontColor,
                                  ),
                                  TextWidget(
                                    edgeInsetsGeometry: EdgeInsets.zero,
                                    value: getAllAppointment[index]!
                                        .doctorProfileHospitalLocationName!,
                                    size: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    textColor: Properties.fontColor,
                                  ),
                                ],
                              ),
                              Spacer(),

                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                    borderRadius:
                                    BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0
                                  ),
                                  child: Image.network(
                                    ApiServices.IMAGE_BASE_URL+getAllAppointment[index]!
                                        .doctorProfileImage!,
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                             /* CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  ApiServices.IMAGE_BASE_URL+getAllAppointment[index]!
                                      .doctorProfileImage!,
                                ),
                              )*/


                            ],
                          ),
                          Divider(
                            color: Colors.black54,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.zero,
                                        value: DateFormat("yyyy-MM-dd")
                                            .format(getAllAppointment[index]!
                                                .doctorAppointmentPreferDate!)
                                            .toString(), //getAllAppointment[index]!.doctorAppointmentPreferDate!.toString(),
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.fontColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_rounded),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry: EdgeInsets.zero,
                                        value: getAllAppointment[index]!
                                            .doctorAppointmentPreferTime!,
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.fontColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  getAllAppointment[index]!
                                      .doctorAppointmentStatus ==
                                      'Booked'
                                      ? Row(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(
                                                100)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry:
                                        EdgeInsets.zero,
                                        value: getAllAppointment[index]!
                                            .doctorAppointmentStatus!,
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.fontColor,
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius.circular(
                                                100)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TextWidget(
                                        edgeInsetsGeometry:
                                        EdgeInsets.zero,
                                        value: getAllAppointment[index]!
                                            .doctorAppointmentStatus!,
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.fontColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            )),
    ));
  }


}
//Text(getAllAppointment[index]!.doctorProfileName!)
