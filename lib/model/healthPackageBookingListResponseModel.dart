// To parse this JSON data, do
//
//     final healthPackageBookingListResponseModel = healthPackageBookingListResponseModelFromJson(jsonString);

import 'dart:convert';

HealthPackageBookingListResponseModel? healthPackageBookingListResponseModelFromJson(String str) => HealthPackageBookingListResponseModel.fromJson(json.decode(str));

String healthPackageBookingListResponseModelToJson(HealthPackageBookingListResponseModel? data) => json.encode(data!.toJson());

class HealthPackageBookingListResponseModel {
  HealthPackageBookingListResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<HealthPackageBookingList?>? data;
  int? statusCode;

  factory HealthPackageBookingListResponseModel.fromJson(Map<String, dynamic> json) => HealthPackageBookingListResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<HealthPackageBookingList?>.from(json["data"]!.map((x) => HealthPackageBookingList.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class HealthPackageBookingList {
  HealthPackageBookingList({
    this.healthPackageBookingId,
    this.healthPackageId,
    this.hospitalLocationId,
    this.healthPackageAppsUserId,
    this.healthPackageBookingUserFirstName,
    this.healthPackageBookingUserLastName,
    this.healthPackageBookingUserNumber,
    this.healthPackageBookingUserEmailId,
    this.healthPackageBookingUserGender,
    this.healthPackageBookingPackageName,
    this.healthPackageBookingConfirmationId,
    this.healthPackageBookingUserNationality,
    this.healthPackageBookingPrepableDate,
    this.healthPackageBookingPrepableTime,
    this.healthPackageBookingLocation,
    this.healthPackageBookingPrice,
    this.healthPackageBookingPaymentMethod,
    this.healthPackageBookingForWhom,
    this.healthPackageBookingAnyMessage,
    this.healthPackageBookingForCompanyName,
    this.healthPackageBookingForCompanyNumber,
    this.healthPackageBookingForCompanyEmail,
    this.healthPackageBookingForCompanyAuthorizedPerson,
    this.healthPackageBookingForCompanyAddress,
    this.healthPackageBookingAddedDateTime,
    this.healthPackageBookingStatus,
    this.createdAt,
    this.updatedAt,
    this.healthPackageTitle,
    this.healthPackageName,
    this.healthPackagePrice,
    this.healthPackageImage,
  });

  int? healthPackageBookingId;
  int? healthPackageId;
  int? hospitalLocationId;
  int? healthPackageAppsUserId;
  String? healthPackageBookingUserFirstName;
  String? healthPackageBookingUserLastName;
  String? healthPackageBookingUserNumber;
  String? healthPackageBookingUserEmailId;
  String? healthPackageBookingUserGender;
  String? healthPackageBookingPackageName;
  String? healthPackageBookingConfirmationId;
  String? healthPackageBookingUserNationality;
  DateTime? healthPackageBookingPrepableDate;
  String? healthPackageBookingPrepableTime;
  String? healthPackageBookingLocation;
  String? healthPackageBookingPrice;
  String? healthPackageBookingPaymentMethod;
  String? healthPackageBookingForWhom;
  dynamic healthPackageBookingAnyMessage;
  dynamic healthPackageBookingForCompanyName;
  dynamic healthPackageBookingForCompanyNumber;
  dynamic healthPackageBookingForCompanyEmail;
  dynamic healthPackageBookingForCompanyAuthorizedPerson;
  dynamic healthPackageBookingForCompanyAddress;
  DateTime? healthPackageBookingAddedDateTime;
  String? healthPackageBookingStatus;
  dynamic createdAt;
  dynamic updatedAt;
  String? healthPackageTitle;
  String? healthPackageName;
  String? healthPackagePrice;
  String? healthPackageImage;

  factory HealthPackageBookingList.fromJson(Map<String, dynamic> json) => HealthPackageBookingList(
    healthPackageBookingId: json["health_package_booking_id"],
    healthPackageId: json["health_package_id"],
    hospitalLocationId: json["hospital_location_id"],
    healthPackageAppsUserId: json["health_package_apps_user_id"],
    healthPackageBookingUserFirstName: json["health_package_booking_user_first_name"],
    healthPackageBookingUserLastName: json["health_package_booking_user_last_name"],
    healthPackageBookingUserNumber: json["health_package_booking_user_number"],
    healthPackageBookingUserEmailId: json["health_package_booking_user_email_id"],
    healthPackageBookingUserGender: json["health_package_booking_user_gender"],
    healthPackageBookingPackageName: json["health_package_booking_package_name"],
    healthPackageBookingConfirmationId: json["health_package_booking_confirmation_id"],
    healthPackageBookingUserNationality: json["health_package_booking_user_nationality"],
    healthPackageBookingPrepableDate: DateTime.parse(json["health_package_booking_prepable_date"]),
    healthPackageBookingPrepableTime: json["health_package_booking_prepable_time"],
    healthPackageBookingLocation: json["health_package_booking_location"],
    healthPackageBookingPrice: json["health_package_booking_price"],
    healthPackageBookingPaymentMethod: json["health_package_booking_payment_method"],
    healthPackageBookingForWhom: json["health_package_booking_for_whom"],
    healthPackageBookingAnyMessage: json["health_package_booking_any_message"],
    healthPackageBookingForCompanyName: json["health_package_booking_for_company_name"],
    healthPackageBookingForCompanyNumber: json["health_package_booking_for_company_number"],
    healthPackageBookingForCompanyEmail: json["health_package_booking_for_company_email"],
    healthPackageBookingForCompanyAuthorizedPerson: json["health_package_booking_for_company_authorized_person"],
    healthPackageBookingForCompanyAddress: json["health_package_booking_for_company_address"],
    healthPackageBookingAddedDateTime: DateTime.parse(json["health_package_booking_added_date_time"]),
    healthPackageBookingStatus: json["health_package_booking_status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    healthPackageTitle: json["health_package_title"],
    healthPackageName: json["health_package_name"],
    healthPackagePrice: json["health_package_price"],
    healthPackageImage: json["health_package_image"],
  );

  Map<String, dynamic> toJson() => {
    "health_package_booking_id": healthPackageBookingId,
    "health_package_id": healthPackageId,
    "hospital_location_id": hospitalLocationId,
    "health_package_apps_user_id": healthPackageAppsUserId,
    "health_package_booking_user_first_name": healthPackageBookingUserFirstName,
    "health_package_booking_user_last_name": healthPackageBookingUserLastName,
    "health_package_booking_user_number": healthPackageBookingUserNumber,
    "health_package_booking_user_email_id": healthPackageBookingUserEmailId,
    "health_package_booking_user_gender": healthPackageBookingUserGender,
    "health_package_booking_package_name": healthPackageBookingPackageName,
    "health_package_booking_confirmation_id": healthPackageBookingConfirmationId,
    "health_package_booking_user_nationality": healthPackageBookingUserNationality,
    "health_package_booking_prepable_date": "${healthPackageBookingPrepableDate!.year.toString().padLeft(4, '0')}-${healthPackageBookingPrepableDate!.month.toString().padLeft(2, '0')}-${healthPackageBookingPrepableDate!.day.toString().padLeft(2, '0')}",
    "health_package_booking_prepable_time": healthPackageBookingPrepableTime,
    "health_package_booking_location": healthPackageBookingLocation,
    "health_package_booking_price": healthPackageBookingPrice,
    "health_package_booking_payment_method": healthPackageBookingPaymentMethod,
    "health_package_booking_for_whom": healthPackageBookingForWhom,
    "health_package_booking_any_message": healthPackageBookingAnyMessage,
    "health_package_booking_for_company_name": healthPackageBookingForCompanyName,
    "health_package_booking_for_company_number": healthPackageBookingForCompanyNumber,
    "health_package_booking_for_company_email": healthPackageBookingForCompanyEmail,
    "health_package_booking_for_company_authorized_person": healthPackageBookingForCompanyAuthorizedPerson,
    "health_package_booking_for_company_address": healthPackageBookingForCompanyAddress,
    "health_package_booking_added_date_time": healthPackageBookingAddedDateTime!.toIso8601String(),
    "health_package_booking_status": healthPackageBookingStatus,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "health_package_title": healthPackageTitle,
    "health_package_name": healthPackageName,
    "health_package_price": healthPackagePrice,
    "health_package_image": healthPackageImage,
  };
}
