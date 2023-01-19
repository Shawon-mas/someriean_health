// To parse this JSON data, do
//
//     final doctorTimeSlotResponseModel = doctorTimeSlotResponseModelFromJson(jsonString);

import 'dart:convert';

DoctorTimeSlotResponseModel doctorTimeSlotResponseModelFromJson(String str) => DoctorTimeSlotResponseModel.fromJson(json.decode(str));

String doctorTimeSlotResponseModelToJson(DoctorTimeSlotResponseModel data) => json.encode(data.toJson());

class DoctorTimeSlotResponseModel {
  DoctorTimeSlotResponseModel({
     this.status,
     this.message,
     this.data,
     this.statusCode,
  });

  bool? status;
  String? message;
  List<TimeSlotDatum?>? data;
  int? statusCode;

  factory DoctorTimeSlotResponseModel.fromJson(Map<String, dynamic> json) => DoctorTimeSlotResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TimeSlotDatum?>.from(json["data"]!.map((x) => TimeSlotDatum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class TimeSlotDatum {
  TimeSlotDatum({
    required this.doctorTimeSlotId,
    required this.doctorProfileId,
    required this.doctorSlotDate,
    required this.doctorSlotTime,
    required this.doctorSlotTimeIsBooked,
    this.doctorSlotTimeBookedTime,
    this.doctorSlotTimeBookedAppsUserId,
    required this.doctorSlotTimeAddedUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  int? doctorTimeSlotId;
  int? doctorProfileId;
  DateTime? doctorSlotDate;
  String? doctorSlotTime;
  String? doctorSlotTimeIsBooked;
  dynamic doctorSlotTimeBookedTime;
  dynamic doctorSlotTimeBookedAppsUserId;
  int? doctorSlotTimeAddedUserId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TimeSlotDatum.fromJson(Map<String, dynamic> json) => TimeSlotDatum(
    doctorTimeSlotId: json["doctor_time_slot_id"],
    doctorProfileId: json["doctor_profile_id"],
    doctorSlotDate: DateTime.parse(json["doctor_slot_date"]),
    doctorSlotTime: json["doctor_slot_time"],
    doctorSlotTimeIsBooked: json["doctor_slot_time_is_booked"],
    doctorSlotTimeBookedTime: json["doctor_slot_time_booked_time"],
    doctorSlotTimeBookedAppsUserId: json["doctor_slot_time_booked_apps_user_id"],
    doctorSlotTimeAddedUserId: json["doctor_slot_time_added_user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "doctor_time_slot_id": doctorTimeSlotId,
    "doctor_profile_id": doctorProfileId,
    "doctor_slot_date": doctorSlotDate?.toIso8601String(),
    "doctor_slot_time": doctorSlotTime,
    "doctor_slot_time_is_booked": doctorSlotTimeIsBooked,
    "doctor_slot_time_booked_time": doctorSlotTimeBookedTime,
    "doctor_slot_time_booked_apps_user_id": doctorSlotTimeBookedAppsUserId,
    "doctor_slot_time_added_user_id": doctorSlotTimeAddedUserId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
