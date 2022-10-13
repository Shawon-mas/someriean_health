import 'package:flutter/material.dart';
import 'package:somerian_health/controller/doctor_appointment_controller.dart';

import '../../../widget/common_toolbar.dart';

class CompleteAppointmentScreen extends StatelessWidget {
  final DoctorAppointmentController controller;
  const CompleteAppointmentScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete Payment'),
      body: Column(
        children: [
          //String 
          Text(controller.selectedDoctor.name),
          Text(controller.selectedDoctor.title),
          Text(controller.selectedDoctor.location),
          Text('${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}'),
          Text(controller.selectedTime.value
                                .format(context)
                                .toString()),
          Text(controller.selectedDoctor.location),
        ],
      ),
    );
  }
}
