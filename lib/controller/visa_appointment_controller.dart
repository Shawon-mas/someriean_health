
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VisaScreeningController extends GetxController{

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  var selectGender = "".obs;
  var selectPayment = "".obs;

  final gender = ['Male', 'Female', 'Others'];
  final paymentMethods = [' Pay Online', ' Pay at CHSC'];
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var genderController = TextEditingController();
  var nationalityController = TextEditingController();
  var emailController = TextEditingController();
  var passportController = TextEditingController();
  var timeAndDateController = TextEditingController();
  var messageController = TextEditingController();
  var emiratesController = TextEditingController();

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2101),
        helpText: 'Select Appointment Date');
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