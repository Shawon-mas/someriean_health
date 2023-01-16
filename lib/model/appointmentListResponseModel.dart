// To parse this JSON data, do
//
//     final appointmentListResponseModel = appointmentListResponseModelFromJson(jsonString);

import 'dart:convert';

AppointmentListResponseModel? appointmentListResponseModelFromJson(String str) => AppointmentListResponseModel.fromJson(json.decode(str));

String appointmentListResponseModelToJson(AppointmentListResponseModel? data) => json.encode(data!.toJson());

class AppointmentListResponseModel {
  AppointmentListResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<AppointmentListDatum?>? data;
  int? statusCode;

  factory AppointmentListResponseModel.fromJson(Map<String, dynamic> json) => AppointmentListResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AppointmentListDatum?>.from(json["data"]!.map((x) => AppointmentListDatum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class AppointmentListDatum {
  AppointmentListDatum({
    this.doctorAppointmentId,
    this.doctorProfileId,
    this.doctorAppointmentPreferDate,
    this.doctorAppointmentPreferTime,
    this.doctorAppointmentBookingFee,
    this.doctorAppointmentUserFirstName,
    this.doctorAppointmentUserLastName,
    this.doctorAppointmentUserMobileNumber,
    this.doctorAppointmentUserGender,
    this.doctorAppointmentUserEmiratesId,
    this.doctorAppointmentUserNationality,
    this.doctorAppointmentAppsUserId,
    this.doctorAppointmentBookingId,
    this.doctorAppointmentStatus,
    this.doctorAppointmentBookIsSelf,
    this.doctorAppointmentBookOthersUserFullName,
    this.doctorAppointmentBookOthersUserEmiratesId,
    this.doctorAppointmentBookOthersUserRelationship,
    this.doctorAppointmentBookOthersUserMobileNumber,
    this.doctorAppointmentBookDateTime,
    this.createdAt,
    this.updatedAt,
    this.doctorProfileName,
    this.doctorProfileSpecialitiesName,
    this.doctorProfileHospitalLocationName,
    this.doctorProfileImage,
    this.doctorProfileMobileNumber,
  });

  int? doctorAppointmentId;
  int? doctorProfileId;
  DateTime? doctorAppointmentPreferDate;
  String? doctorAppointmentPreferTime;
  String? doctorAppointmentBookingFee;
  String? doctorAppointmentUserFirstName;
  String? doctorAppointmentUserLastName;
  String? doctorAppointmentUserMobileNumber;
  String? doctorAppointmentUserGender;
  String? doctorAppointmentUserEmiratesId;
  String? doctorAppointmentUserNationality;
  int? doctorAppointmentAppsUserId;
  String? doctorAppointmentBookingId;
  String? doctorAppointmentStatus;
  String? doctorAppointmentBookIsSelf;
  String? doctorAppointmentBookOthersUserFullName;
  String? doctorAppointmentBookOthersUserEmiratesId;
  String? doctorAppointmentBookOthersUserRelationship;
  String? doctorAppointmentBookOthersUserMobileNumber;
  DateTime? doctorAppointmentBookDateTime;
  dynamic createdAt;
  dynamic updatedAt;
  String? doctorProfileName;
  String? doctorProfileSpecialitiesName;
  String? doctorProfileHospitalLocationName;
  String? doctorProfileImage;
  String? doctorProfileMobileNumber;

  factory AppointmentListDatum.fromJson(Map<String, dynamic> json) => AppointmentListDatum(
    doctorAppointmentId: json["doctor_appointment_id"],
    doctorProfileId: json["doctor_profile_id"],
    doctorAppointmentPreferDate: DateTime.parse(json["doctor_appointment_prefer_date"]),
    doctorAppointmentPreferTime: json["doctor_appointment_prefer_time"],
    doctorAppointmentBookingFee: json["doctor_appointment_booking_fee"],
    doctorAppointmentUserFirstName: json["doctor_appointment_user_first_name"],
    doctorAppointmentUserLastName: json["doctor_appointment_user_last_name"],
    doctorAppointmentUserMobileNumber: json["doctor_appointment_user_mobile_number"],
    doctorAppointmentUserGender: json["doctor_appointment_user_gender"],
    doctorAppointmentUserEmiratesId: json["doctor_appointment_user_emirates_id"],
    doctorAppointmentUserNationality: json["doctor_appointment_user_nationality"],
    doctorAppointmentAppsUserId: json["doctor_appointment_apps_user_id"],
    doctorAppointmentBookingId: json["doctor_appointment_booking_id"],
    doctorAppointmentStatus: json["doctor_appointment_status"],
    doctorAppointmentBookIsSelf: json["doctor_appointment_book_is_self"],
    doctorAppointmentBookOthersUserFullName: json["doctor_appointment_book_others_user_full_name"],
    doctorAppointmentBookOthersUserEmiratesId: json["doctor_appointment_book_others_user_emirates_id"],
    doctorAppointmentBookOthersUserRelationship: json["doctor_appointment_book_others_user_relationship"],
    doctorAppointmentBookOthersUserMobileNumber: json["doctor_appointment_book_others_user_mobile_number"],
    doctorAppointmentBookDateTime: DateTime.parse(json["doctor_appointment_book_date_time"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    doctorProfileName: json["doctor_profile_name"],
    doctorProfileSpecialitiesName: json["doctor_profile_specialities_name"],
    doctorProfileHospitalLocationName: json["doctor_profile_hospital_location_name"],
    doctorProfileImage: json["doctor_profile_image"],
    doctorProfileMobileNumber: json["doctor_profile_mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_appointment_id": doctorAppointmentId,
    "doctor_profile_id": doctorProfileId,
    "doctor_appointment_prefer_date": "${doctorAppointmentPreferDate!.year.toString().padLeft(4, '0')}-${doctorAppointmentPreferDate!.month.toString().padLeft(2, '0')}-${doctorAppointmentPreferDate!.day.toString().padLeft(2, '0')}",
    "doctor_appointment_prefer_time": doctorAppointmentPreferTime,
    "doctor_appointment_booking_fee": doctorAppointmentBookingFee,
    "doctor_appointment_user_first_name": doctorAppointmentUserFirstName,
    "doctor_appointment_user_last_name": doctorAppointmentUserLastName,
    "doctor_appointment_user_mobile_number": doctorAppointmentUserMobileNumber,
    "doctor_appointment_user_gender": doctorAppointmentUserGender,
    "doctor_appointment_user_emirates_id": doctorAppointmentUserEmiratesId,
    "doctor_appointment_user_nationality": doctorAppointmentUserNationality,
    "doctor_appointment_apps_user_id": doctorAppointmentAppsUserId,
    "doctor_appointment_booking_id": doctorAppointmentBookingId,
    "doctor_appointment_status": doctorAppointmentStatus,
    "doctor_appointment_book_is_self": doctorAppointmentBookIsSelf,
    "doctor_appointment_book_others_user_full_name": doctorAppointmentBookOthersUserFullName,
    "doctor_appointment_book_others_user_emirates_id": doctorAppointmentBookOthersUserEmiratesId,
    "doctor_appointment_book_others_user_relationship": doctorAppointmentBookOthersUserRelationship,
    "doctor_appointment_book_others_user_mobile_number": doctorAppointmentBookOthersUserMobileNumber,
    "doctor_appointment_book_date_time": doctorAppointmentBookDateTime?.toIso8601String(),
    "created_at": createdAt,
    "updated_at": updatedAt,
    "doctor_profile_name": doctorProfileName,
    "doctor_profile_specialities_name": doctorProfileSpecialitiesName,
    "doctor_profile_hospital_location_name": doctorProfileHospitalLocationName,
    "doctor_profile_image": doctorProfileImage,
    "doctor_profile_mobile_number": doctorProfileMobileNumber,
  };
}
