// To parse this JSON data, do
//
//     final visaScreeningBookingListModel = visaScreeningBookingListModelFromJson(jsonString);

import 'dart:convert';

VisaScreeningBookingListModel? visaScreeningBookingListModelFromJson(String str) => VisaScreeningBookingListModel.fromJson(json.decode(str));

String visaScreeningBookingListModelToJson(VisaScreeningBookingListModel? data) => json.encode(data!.toJson());

class VisaScreeningBookingListModel {
  VisaScreeningBookingListModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  dynamic status;
  dynamic message;
  List<VisaBookingList?>? data;
  dynamic statusCode;

  factory VisaScreeningBookingListModel.fromJson(Map<String, dynamic> json) => VisaScreeningBookingListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<VisaBookingList?>.from(json["data"]!.map((x) => VisaBookingList.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class VisaBookingList {
  VisaBookingList({
    this.visaScreeningServiceId,
    this.visaScreeningServiceTypeId,
    this.visaScreeningEmirateId,
    this.visaScreeningPackageId,
    this.visaScreeningLocationId,
    this.visaScreeningAppsUserId,
    this.visaScreeningUserFirstName,
    this.visaScreeningUserLastName,
    this.visaScreeningUserBirthDate,
    this.visaScreeningUserGender,
    this.visaScreeningUserPhoneNumber,
    this.visaScreeningUserEmail,
    this.visaScreeningUserAddress,
    this.visaScreeningUserEmirateName,
    this.visaScreeningUserPreparedDate,
    this.visaScreeningUserPreparedTime,
    this.visaScreeningUserPackageName,
    this.visaScreeningUserVisaType,
    this.visaScreeningUserPaymentType,
    this.visaScreeningUserLocationName,
    this.visaScreeningUserCompanyName,
    this.visaScreeningUserTypeOfScreening,
    this.visaScreeningUserRepresentativeName,
    this.visaScreeningUserNumberOfPeople,
    this.visaScreeningBookingId,
    this.visaScreeningBookingStatus,
    this.visaScreeningAddedTime,
    this.createdAt,
    this.updatedAt,
  });

  dynamic visaScreeningServiceId;
  dynamic visaScreeningServiceTypeId;
  dynamic visaScreeningEmirateId;
  dynamic visaScreeningPackageId;
  dynamic visaScreeningLocationId;
  dynamic visaScreeningAppsUserId;
  dynamic visaScreeningUserFirstName;
  dynamic visaScreeningUserLastName;
  DateTime? visaScreeningUserBirthDate;
  dynamic visaScreeningUserGender;
  dynamic visaScreeningUserPhoneNumber;
  dynamic visaScreeningUserEmail;
  dynamic visaScreeningUserAddress;
  dynamic visaScreeningUserEmirateName;
  DateTime? visaScreeningUserPreparedDate;
  dynamic visaScreeningUserPreparedTime;
  dynamic visaScreeningUserPackageName;
  dynamic visaScreeningUserVisaType;
  dynamic visaScreeningUserPaymentType;
  dynamic visaScreeningUserLocationName;
  dynamic visaScreeningUserCompanyName;
  dynamic visaScreeningUserTypeOfScreening;
  dynamic visaScreeningUserRepresentativeName;
  dynamic visaScreeningUserNumberOfPeople;
  dynamic visaScreeningBookingId;
  dynamic visaScreeningBookingStatus;
  DateTime? visaScreeningAddedTime;
  dynamic createdAt;
  dynamic updatedAt;

  factory VisaBookingList.fromJson(Map<String, dynamic> json) => VisaBookingList(
    visaScreeningServiceId: json["visa_screening_service_id"],
    visaScreeningServiceTypeId: json["visa_screening_service_type_id"],
    visaScreeningEmirateId: json["visa_screening_emirate_id"],
    visaScreeningPackageId: json["visa_screening_package_id"],
    visaScreeningLocationId: json["visa_screening_location_id"],
    visaScreeningAppsUserId: json["visa_screening_apps_user_id"],
    visaScreeningUserFirstName: json["visa_screening_user_first_name"],
    visaScreeningUserLastName: json["visa_screening_user_last_name"],
    visaScreeningUserBirthDate: DateTime.parse(json["visa_screening_user_birth_date"]),
    visaScreeningUserGender: json["visa_screening_user_gender"],
    visaScreeningUserPhoneNumber: json["visa_screening_user_phone_number"],
    visaScreeningUserEmail: json["visa_screening_user_email"],
    visaScreeningUserAddress: json["visa_screening_user_address"],
    visaScreeningUserEmirateName: json["visa_screening_user_emirate_name"],
    visaScreeningUserPreparedDate: DateTime.parse(json["visa_screening_user_prepared_date"]),
    visaScreeningUserPreparedTime: json["visa_screening_user_prepared_time"],
    visaScreeningUserPackageName: json["visa_screening_user_package_name"],
    visaScreeningUserVisaType: json["visa_screening_user_visa_type"],
    visaScreeningUserPaymentType: json["visa_screening_user_payment_type"],
    visaScreeningUserLocationName: json["visa_screening_user_location_name"],
    visaScreeningUserCompanyName: json["visa_screening_user_company_name"],
    visaScreeningUserTypeOfScreening: json["visa_screening_user_type_of_screening"],
    visaScreeningUserRepresentativeName: json["visa_screening_user_representative_name"],
    visaScreeningUserNumberOfPeople: json["visa_screening_user_number_of_people"],
    visaScreeningBookingId: json["visa_screening_booking_id"],
    visaScreeningBookingStatus: json["visa_screening_booking_status"],
    visaScreeningAddedTime: DateTime.parse(json["visa_screening_added_time"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "visa_screening_service_id": visaScreeningServiceId,
    "visa_screening_service_type_id": visaScreeningServiceTypeId,
    "visa_screening_emirate_id": visaScreeningEmirateId,
    "visa_screening_package_id": visaScreeningPackageId,
    "visa_screening_location_id": visaScreeningLocationId,
    "visa_screening_apps_user_id": visaScreeningAppsUserId,
    "visa_screening_user_first_name": visaScreeningUserFirstName,
    "visa_screening_user_last_name": visaScreeningUserLastName,
    "visa_screening_user_birth_date": "${visaScreeningUserBirthDate!.year.toString().padLeft(4, '0')}-${visaScreeningUserBirthDate!.month.toString().padLeft(2, '0')}-${visaScreeningUserBirthDate!.day.toString().padLeft(2, '0')}",
    "visa_screening_user_gender": visaScreeningUserGender,
    "visa_screening_user_phone_number": visaScreeningUserPhoneNumber,
    "visa_screening_user_email": visaScreeningUserEmail,
    "visa_screening_user_address": visaScreeningUserAddress,
    "visa_screening_user_emirate_name": visaScreeningUserEmirateName,
    "visa_screening_user_prepared_date": "${visaScreeningUserPreparedDate!.year.toString().padLeft(4, '0')}-${visaScreeningUserPreparedDate!.month.toString().padLeft(2, '0')}-${visaScreeningUserPreparedDate!.day.toString().padLeft(2, '0')}",
    "visa_screening_user_prepared_time": visaScreeningUserPreparedTime,
    "visa_screening_user_package_name": visaScreeningUserPackageName,
    "visa_screening_user_visa_type": visaScreeningUserVisaType,
    "visa_screening_user_payment_type": visaScreeningUserPaymentType,
    "visa_screening_user_location_name": visaScreeningUserLocationName,
    "visa_screening_user_company_name": visaScreeningUserCompanyName,
    "visa_screening_user_type_of_screening": visaScreeningUserTypeOfScreening,
    "visa_screening_user_representative_name": visaScreeningUserRepresentativeName,
    "visa_screening_user_number_of_people": visaScreeningUserNumberOfPeople,
    "visa_screening_booking_id": visaScreeningBookingId,
    "visa_screening_booking_status": visaScreeningBookingStatus,
    "visa_screening_added_time": visaScreeningAddedTime!.toIso8601String(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
