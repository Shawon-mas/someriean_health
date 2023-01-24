// To parse this JSON data, do
//
//     final visaScreeningLocationModel = visaScreeningLocationModelFromJson(jsonString);

import 'dart:convert';

VisaScreeningLocationModel? visaScreeningLocationModelFromJson(String str) => VisaScreeningLocationModel.fromJson(json.decode(str));

String visaScreeningLocationModelToJson(VisaScreeningLocationModel? data) => json.encode(data!.toJson());

class VisaScreeningLocationModel {
  VisaScreeningLocationModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<VisaLocation?>? data;
  int? statusCode;

  factory VisaScreeningLocationModel.fromJson(Map<String, dynamic> json) => VisaScreeningLocationModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<VisaLocation?>.from(json["data"]!.map((x) => VisaLocation.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class VisaLocation {
  VisaLocation({
    this.visaScreeningLocationId,
    this.visaScreeningLocationName,
    this.visaScreeningLocationIsActive,
    this.visaScreeningLocationAddedUserId,
    this.visaScreeningLocationAddedTime,
    this.createdAt,
    this.updatedAt,
  });

  int? visaScreeningLocationId;
  String? visaScreeningLocationName;
  int? visaScreeningLocationIsActive;
  dynamic visaScreeningLocationAddedUserId;
  DateTime? visaScreeningLocationAddedTime;
  dynamic createdAt;
  dynamic updatedAt;

  factory VisaLocation.fromJson(Map<String, dynamic> json) => VisaLocation(
    visaScreeningLocationId: json["visa_screening_location_id"],
    visaScreeningLocationName: json["visa_screening_location_name"],
    visaScreeningLocationIsActive: json["visa_screening_location_is_active"],
    visaScreeningLocationAddedUserId: json["visa_screening_location_added_user_id"],
    visaScreeningLocationAddedTime: DateTime.parse(json["visa_screening_location_added_time"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "visa_screening_location_id": visaScreeningLocationId,
    "visa_screening_location_name": visaScreeningLocationName,
    "visa_screening_location_is_active": visaScreeningLocationIsActive,
    "visa_screening_location_added_user_id": visaScreeningLocationAddedUserId,
    "visa_screening_location_added_time": visaScreeningLocationAddedTime!.toIso8601String(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
