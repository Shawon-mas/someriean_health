import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../controller/doctor_appointment_list_controller.dart';
import '../../../../global/properties.dart';
import '../../../../model/healthPackageBookingListResponseModel.dart';
import '../../../../model/visaScreeningBookingListModel.dart';
import '../../../widget/text_widget.dart';

class VisaAppointmentList extends StatelessWidget {
  final controller = Get.put(DoctorAppointmentListController());
  VisaAppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.dataFetchVisa.value == true
          ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.visaAppointmentList.length,
              itemBuilder: (context, index) {
                List<VisaBookingList?> getAllAppointment = controller.visaAppointmentList;

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
                                    value: getAllAppointment[index]!.visaScreeningUserPackageName!??'',
                                    size: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: Properties.fontColor,
                                  ),
                                  TextWidget(
                                    edgeInsetsGeometry: EdgeInsets.zero,
                                    value: getAllAppointment[index]!.visaScreeningUserEmirateName!??'',
                                    size: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    textColor: Properties.fontColor,
                                  ),
                                  TextWidget(
                                    edgeInsetsGeometry: EdgeInsets.zero,
                                    value: getAllAppointment[index]!.visaScreeningUserVisaType!??'',
                                    size: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    textColor: Properties.fontColor,
                                  ),
                                ],
                              ),
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
                                                .visaScreeningUserPreparedDate!)
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
                                            .visaScreeningUserPreparedTime!,
                                        size: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: Properties.fontColor,
                                      ),
                                    ],
                                  ),
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
    );
  }
}
