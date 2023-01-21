// To parse this JSON data, do
//
//     final healthPackageListResponseModel = healthPackageListResponseModelFromJson(jsonString);

import 'dart:convert';

HealthPackageListResponseModel healthPackageListResponseModelFromJson(String str) => HealthPackageListResponseModel.fromJson(json.decode(str));

String healthPackageListResponseModelToJson(HealthPackageListResponseModel data) => json.encode(data.toJson());

class HealthPackageListResponseModel {
  HealthPackageListResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<HealthPackageDatum?>? data;
  int? statusCode;

  factory HealthPackageListResponseModel.fromJson(Map<String, dynamic> json) => HealthPackageListResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<HealthPackageDatum?>.from(json["data"]!.map((x) => HealthPackageDatum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class HealthPackageDatum {
  HealthPackageDatum({
    this.healthPackageId,
    this.healthPackageTitle,
    this.healthPackageName,
    this.healthPackagePrice,
    this.healthPackageImage,
    this.healthPackageDetails,
    this.healthPackageAddedUserId,
    this.healthPackageAddedTime,
    this.healthPackageIsActive,
    this.createdAt,
    this.updatedAt,
  });

  int? healthPackageId;
  String? healthPackageTitle;
  String? healthPackageName;
  String? healthPackagePrice;
  String? healthPackageImage;
  String? healthPackageDetails;
  int? healthPackageAddedUserId;
  DateTime? healthPackageAddedTime;
  int? healthPackageIsActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HealthPackageDatum.fromJson(Map<String, dynamic> json) => HealthPackageDatum(
    healthPackageId: json["health_package_id"],
    healthPackageTitle: json["health_package_title"],
    healthPackageName: json["health_package_name"],
    healthPackagePrice: json["health_package_price"],
    healthPackageImage: json["health_package_image"],
    healthPackageDetails: json["health_package_details"],
    healthPackageAddedUserId: json["health_package_added_user_id"],
    healthPackageAddedTime: DateTime.parse(json["health_package_added_time"]),
    healthPackageIsActive: json["health_package_is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "health_package_id": healthPackageId,
    "health_package_title": healthPackageTitle,
    "health_package_name": healthPackageName,
    "health_package_price": healthPackagePrice,
    "health_package_image": healthPackageImage,
    "health_package_details": healthPackageDetails,
    "health_package_added_user_id": healthPackageAddedUserId,
    "health_package_added_time": healthPackageAddedTime?.toIso8601String(),
    "health_package_is_active": healthPackageIsActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
