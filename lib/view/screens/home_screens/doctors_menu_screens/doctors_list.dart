import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/doctor_appointment_controller.dart';
import '../../../widget/common_toolbar.dart';

class DoctorList extends StatelessWidget {
  final _controller = Get.put(DoctorAppointmentController());
  DoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Doctors'),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text('Location'),
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: _controller.selectedLocation.value == ""
                          ? null
                          : _controller.selectedLocation.value,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _controller.locations.map((items) {
                        return DropdownMenuItem(
                          value: items!.hospitalLocationName!.toString(),
                          child: Text(items.hospitalLocationName!.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        _controller.selectedLocation.value = newValue as String;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text('Specialty'),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _controller.selectedSpeciality.value == ""
                          ? null
                          : _controller.selectedSpeciality.value,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _controller.speciality.map((items) {
                        return DropdownMenuItem(
                          value: items!.doctorSpecialitiesName!.toString(),
                          child: Text(items.doctorSpecialitiesName!.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        _controller.selectedSpeciality.value = newValue as String;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
