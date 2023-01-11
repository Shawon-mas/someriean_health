// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromJson(jsonString);

import 'dart:convert';

LocationResponseModel? locationResponseModelFromJson(String str) => LocationResponseModel.fromJson(json.decode(str));

String locationResponseModelToJson(LocationResponseModel? data) => json.encode(data!.toJson());

class LocationResponseModel {
  LocationResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<LocationDatum?>? data;
  int? statusCode;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LocationDatum?>.from(json["data"]!.map((x) => LocationDatum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class LocationDatum {
  LocationDatum({
    this.hospitalLocationId,
    this.hospitalLocationName,
    this.hospitalLocationAddress,
    this.hospitalLocationIsActive,
    this.hospitalLocationCreatedDateTime,
    this.hospitalLocationCreatedId,
    this.createdAt,
    this.updatedAt,
  });

  int? hospitalLocationId;
  String? hospitalLocationName;
  String? hospitalLocationAddress;
  int? hospitalLocationIsActive;
  DateTime? hospitalLocationCreatedDateTime;
  int? hospitalLocationCreatedId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory LocationDatum.fromJson(Map<String, dynamic> json) => LocationDatum(
    hospitalLocationId: json["hospital_location_id"],
    hospitalLocationName: json["hospital_location_name"],
    hospitalLocationAddress: json["hospital_location_address"],
    hospitalLocationIsActive: json["hospital_location_is_active"],
    hospitalLocationCreatedDateTime: DateTime.parse(json["hospital_location_created_date_time"]),
    hospitalLocationCreatedId: json["hospital_location_created_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "hospital_location_id": hospitalLocationId,
    "hospital_location_name": hospitalLocationName,
    "hospital_location_address": hospitalLocationAddress,
    "hospital_location_is_active": hospitalLocationIsActive,
    "hospital_location_created_date_time": hospitalLocationCreatedDateTime?.toIso8601String(),
    "hospital_location_created_id": hospitalLocationCreatedId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
