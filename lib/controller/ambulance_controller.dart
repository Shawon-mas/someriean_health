import 'package:get/get.dart';

import '../model/selected_ambulance_model.dart';
import 'package:flutter/material.dart';

class AmbulanceController extends GetxController{
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var selectedAmbulance=SelectedAmbulance(
    uid: "",
    name: "",
    image: "",
    service: ""
  );
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
  }
  selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 30),
    );
    selectedTime.value = picked!;
  }


}