// To parse this JSON data, do
//
//     final visaPackagesResponseModel = visaPackagesResponseModelFromJson(jsonString);

import 'dart:convert';

VisaPackagesResponseModel? visaPackagesResponseModelFromJson(String str) => VisaPackagesResponseModel.fromJson(json.decode(str));

String visaPackagesResponseModelToJson(VisaPackagesResponseModel? data) => json.encode(data!.toJson());

class VisaPackagesResponseModel {
  VisaPackagesResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<VisaPackagesList?>? data;
  int? statusCode;

  factory VisaPackagesResponseModel.fromJson(Map<String, dynamic> json) => VisaPackagesResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<VisaPackagesList?>.from(json["data"]!.map((x) => VisaPackagesList.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class VisaPackagesList {
  VisaPackagesList({
    this.visaScreeningPackageId,
    this.visaScreeningPackageName,
    this.visaScreeningPackageShortTitle,
    this.visaScreeningPackagePrice,
    this.visaScreeningPackageDetails,
    this.visaScreeningPackageIsActive,
    this.visaScreeningPackageAddedUserId,
    this.visaScreeningPackageAddedTime,
    this.createdAt,
    this.updatedAt,
  });

  int? visaScreeningPackageId;
  String? visaScreeningPackageName;
  dynamic visaScreeningPackageShortTitle;
  String? visaScreeningPackagePrice;
  String? visaScreeningPackageDetails;
  int? visaScreeningPackageIsActive;
  int? visaScreeningPackageAddedUserId;
  DateTime? visaScreeningPackageAddedTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory VisaPackagesList.fromJson(Map<String, dynamic> json) => VisaPackagesList(
    visaScreeningPackageId: json["visa_screening_package_id"],
    visaScreeningPackageName: json["visa_screening_package_name"],
    visaScreeningPackageShortTitle: json["visa_screening_package_short_title"],
    visaScreeningPackagePrice: json["visa_screening_package_price"],
    visaScreeningPackageDetails: json["visa_screening_package_details"],
    visaScreeningPackageIsActive: json["visa_screening_package_is_active"],
    visaScreeningPackageAddedUserId: json["visa_screening_package_added_user_id"],
    visaScreeningPackageAddedTime: DateTime.parse(json["visa_screening_package_added_time"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "visa_screening_package_id": visaScreeningPackageId,
    "visa_screening_package_name": visaScreeningPackageName,
    "visa_screening_package_short_title": visaScreeningPackageShortTitle,
    "visa_screening_package_price": visaScreeningPackagePrice,
    "visa_screening_package_details": visaScreeningPackageDetails,
    "visa_screening_package_is_active": visaScreeningPackageIsActive,
    "visa_screening_package_added_user_id": visaScreeningPackageAddedUserId,
    "visa_screening_package_added_time": visaScreeningPackageAddedTime!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
