// To parse this JSON data, do
//
//     final visaEmiratesResponseModel = visaEmiratesResponseModelFromJson(jsonString);

import 'dart:convert';

VisaEmiratesResponseModel? visaEmiratesResponseModelFromJson(String str) => VisaEmiratesResponseModel.fromJson(json.decode(str));

String visaEmiratesResponseModelToJson(VisaEmiratesResponseModel? data) => json.encode(data!.toJson());

class VisaEmiratesResponseModel {
  VisaEmiratesResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<VisaEmiratesList?>? data;
  int? statusCode;

  factory VisaEmiratesResponseModel.fromJson(Map<String, dynamic> json) => VisaEmiratesResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<VisaEmiratesList?>.from(json["data"]!.map((x) => VisaEmiratesList.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class VisaEmiratesList {
  VisaEmiratesList({
    this.visaScreeningEmirateId,
    this.visaScreeningEmirateName,
    this.visaScreeningEmirateIsActive,
    this.visaScreeningEmirateAddedUserId,
    this.visaScreeningEmirateAddedTime,
    this.createdAt,
    this.updatedAt,
  });

  int? visaScreeningEmirateId;
  String? visaScreeningEmirateName;
  int? visaScreeningEmirateIsActive;
  dynamic visaScreeningEmirateAddedUserId;
  DateTime? visaScreeningEmirateAddedTime;
  dynamic createdAt;
  dynamic updatedAt;

  factory VisaEmiratesList.fromJson(Map<String, dynamic> json) => VisaEmiratesList(
    visaScreeningEmirateId: json["visa_screening_emirate_id"],
    visaScreeningEmirateName: json["visa_screening_emirate_name"],
    visaScreeningEmirateIsActive: json["visa_screening_emirate_is_active"],
    visaScreeningEmirateAddedUserId: json["visa_screening_emirate_added_user_id"],
    visaScreeningEmirateAddedTime: DateTime.parse(json["visa_screening_emirate_added_time"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "visa_screening_emirate_id": visaScreeningEmirateId,
    "visa_screening_emirate_name": visaScreeningEmirateName,
    "visa_screening_emirate_is_active": visaScreeningEmirateIsActive,
    "visa_screening_emirate_added_user_id": visaScreeningEmirateAddedUserId,
    "visa_screening_emirate_added_time": visaScreeningEmirateAddedTime!.toIso8601String(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
