import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/manage_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class ManageAppiontment extends StatelessWidget { 
  final _controller = Get.put(ManageAppointmentController());

  @override
  Widget build(BuildContext context) {
    _controller.getAppointments();
    return Scaffold(
      appBar: CommonToolbar(title: 'Appointment List '),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _controller.appointmentLists.value.length,
                itemBuilder: (context, index) {
                  var doctor =
                      _controller.appointmentLists.value[index].doctor!;
                  var appointment =
                      _controller.appointmentLists.value[index].appointment!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
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
                                doctor.image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctor.name,
                                  size: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctor.title,
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: doctor.location,
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: 'Date: ${appointment.date}',
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                                TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: 'Time: ${appointment.time}',
                                  size: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: Properties.fontColor,
                                ),
                              ],
                            )
                          ],
                        ),
                        AppointmentButton(
                          onPressed: () {
                            _controller.deleteAppointment(appointment.uid);
                          },
                          value: 'Cancel Appointment',
                        ),
                        Divider(
                          color: Colors.black54,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
