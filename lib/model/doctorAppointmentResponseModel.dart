// To parse this JSON data, do
//
//     final doctorAppointmentResponseModel = doctorAppointmentResponseModelFromJson(jsonString);

import 'dart:convert';

DoctorAppointmentResponseModel? doctorAppointmentResponseModelFromJson(String str) => DoctorAppointmentResponseModel.fromJson(json.decode(str));

String doctorAppointmentResponseModelToJson(DoctorAppointmentResponseModel? data) => json.encode(data!.toJson());

class DoctorAppointmentResponseModel {
  DoctorAppointmentResponseModel({
    this.status,
    this.message,
    this.data,
    this.smsFormat,
    this.statusCode,
  });

  bool? status;
  String? message;
  Data? data;
  String? smsFormat;
  int? statusCode;

  factory DoctorAppointmentResponseModel.fromJson(Map<String, dynamic> json) => DoctorAppointmentResponseModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    smsFormat: json["sms_format"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
    "sms_format": smsFormat,
    "status_code": statusCode,
  };
}

class Data {
  Data({
    this.bookingId,
    this.bookingDoctorName,
    this.bookingDoctorSpeciality,
    this.bookingHospitalLocation,
    this.bookingDate,
    this.bookingTime,
  });

  String? bookingId;
  String? bookingDoctorName;
  String? bookingDoctorSpeciality;
  String? bookingHospitalLocation;
  DateTime? bookingDate;
  String? bookingTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingId: json["booking_id"],
    bookingDoctorName: json["booking_doctor_name"],
    bookingDoctorSpeciality: json["booking_doctor_speciality"],
    bookingHospitalLocation: json["booking_hospital_location"],
    bookingDate: DateTime.parse(json["booking_date"]),
    bookingTime: json["booking_time"],
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "booking_doctor_name": bookingDoctorName,
    "booking_doctor_speciality": bookingDoctorSpeciality,
    "booking_hospital_location": bookingHospitalLocation,
    "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "booking_time": bookingTime,
  };
}
