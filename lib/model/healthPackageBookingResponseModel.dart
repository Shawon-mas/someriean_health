// To parse this JSON data, do
//
//     final healthPackageBookingResponseModel = healthPackageBookingResponseModelFromJson(jsonString);

import 'dart:convert';

HealthPackageBookingResponseModel? healthPackageBookingResponseModelFromJson(String str) => HealthPackageBookingResponseModel.fromJson(json.decode(str));

String healthPackageBookingResponseModelToJson(HealthPackageBookingResponseModel? data) => json.encode(data!.toJson());

class HealthPackageBookingResponseModel {
  HealthPackageBookingResponseModel({
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

  factory HealthPackageBookingResponseModel.fromJson(Map<String, dynamic> json) => HealthPackageBookingResponseModel(
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
    this.packageBookingId,
    this.healthPackageTitile,
    this.bookingHospitalLocation,
    this.bookingDate,
    this.bookingTime,
  });

  String? packageBookingId;
  String? healthPackageTitile;
  String? bookingHospitalLocation;
  DateTime? bookingDate;
  String? bookingTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    packageBookingId: json["package_booking_id"],
    healthPackageTitile: json["health_package_titile"],
    bookingHospitalLocation: json["booking_hospital_location"],
    bookingDate: DateTime.parse(json["booking_date"]),
    bookingTime: json["booking_time"],
  );

  Map<String, dynamic> toJson() => {
    "package_booking_id": packageBookingId,
    "health_package_titile": healthPackageTitile,
    "booking_hospital_location": bookingHospitalLocation,
    "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "booking_time": bookingTime,
  };
}
