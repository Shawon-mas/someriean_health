// To parse this JSON data, do
//
//     final specialistResponseModel = specialistResponseModelFromJson(jsonString);

import 'dart:convert';

SpecialistResponseModel? specialistResponseModelFromJson(String str) => SpecialistResponseModel.fromJson(json.decode(str));

String specialistResponseModelToJson(SpecialistResponseModel? data) => json.encode(data!.toJson());

class SpecialistResponseModel {
  SpecialistResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<Datum?>? data;
  int? statusCode;

  factory SpecialistResponseModel.fromJson(Map<String, dynamic> json) => SpecialistResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class Datum {
  Datum({
    this.doctorSpecialitiesId,
    this.doctorSpecialitiesName,
    this.doctorSpecialitiesIsActive,
    this.doctorSpecialitiesShortDescription,
    this.doctorSpecialitiesCreatedDate,
    this.doctorSpecialitiesCreatedId,
    this.createdAt,
    this.updatedAt,
  });

  int? doctorSpecialitiesId;
  String? doctorSpecialitiesName;
  int? doctorSpecialitiesIsActive;
  dynamic doctorSpecialitiesShortDescription;
  DateTime? doctorSpecialitiesCreatedDate;
  int? doctorSpecialitiesCreatedId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    doctorSpecialitiesId: json["doctor_specialities_id"],
    doctorSpecialitiesName: json["doctor_specialities_name"],
    doctorSpecialitiesIsActive: json["doctor_specialities_is_active"],
    doctorSpecialitiesShortDescription: json["doctor_specialities_short_description"],
    doctorSpecialitiesCreatedDate: DateTime.parse(json["doctor_specialities_created_date"]),
    doctorSpecialitiesCreatedId: json["doctor_specialities_created_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "doctor_specialities_id": doctorSpecialitiesId,
    "doctor_specialities_name": doctorSpecialitiesName,
    "doctor_specialities_is_active": doctorSpecialitiesIsActive,
    "doctor_specialities_short_description": doctorSpecialitiesShortDescription,
    "doctor_specialities_created_date": doctorSpecialitiesCreatedDate?.toIso8601String(),
    "doctor_specialities_created_id": doctorSpecialitiesCreatedId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
