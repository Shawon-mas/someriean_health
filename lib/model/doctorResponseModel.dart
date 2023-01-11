// To parse this JSON data, do
//
//     final doctorResponseModel = doctorResponseModelFromJson(jsonString);

import 'dart:convert';

DoctorResponseModel? doctorResponseModelFromJson(String str) => DoctorResponseModel.fromJson(json.decode(str));

String doctorResponseModelToJson(DoctorResponseModel? data) => json.encode(data!.toJson());

class DoctorResponseModel {
  DoctorResponseModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<DoctorData?>? data;
  int? statusCode;

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) => DoctorResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DoctorData?>.from(json["data"]!.map((x) => DoctorData.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class DoctorData {
  DoctorData({
    this.doctorProfileId,
    this.doctorProfileName,
    this.doctorProfileDegree,
    this.doctorProfileAdditionalInfo,
    this.doctorProfileImage,
    this.doctorProfileMobileNumber,
    this.doctorProfilePassword,
    this.doctorProfileSpecialitiesName,
    this.doctorConsultationFee,
    this.doctorProfileHospitalLocationName,
    this.doctorSpecialitiesId,
    this.hospitalLocationId,
    this.doctorProfileIsActive,
    this.doctorProfileCreatedUserId,
    this.doctorProfileCreatedDateTime,
    this.createdAt,
    this.updatedAt,
  });

  int? doctorProfileId;
  String? doctorProfileName;
  String? doctorProfileDegree;
  String? doctorProfileAdditionalInfo;
  String? doctorProfileImage;
  String? doctorProfileMobileNumber;
  String? doctorProfilePassword;
  String? doctorProfileSpecialitiesName;
  dynamic doctorConsultationFee;
  String? doctorProfileHospitalLocationName;
  int? doctorSpecialitiesId;
  int? hospitalLocationId;
  int? doctorProfileIsActive;
  int? doctorProfileCreatedUserId;
  DateTime? doctorProfileCreatedDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
    doctorProfileId: json["doctor_profile_id"],
    doctorProfileName: json["doctor_profile_name"],
    doctorProfileDegree: json["doctor_profile_degree"],
    doctorProfileAdditionalInfo: json["doctor_profile_additional_info"],
    doctorProfileImage: json["doctor_profile_image"],
    doctorProfileMobileNumber: json["doctor_profile_mobile_number"],
    doctorProfilePassword: json["doctor_profile_password"],
    doctorProfileSpecialitiesName: json["doctor_profile_specialities_name"],
    doctorConsultationFee: json["doctor_consultation_fee"],
    doctorProfileHospitalLocationName: json["doctor_profile_hospital_location_name"],
    doctorSpecialitiesId: json["doctor_specialities_id"],
    hospitalLocationId: json["hospital_location_id"],
    doctorProfileIsActive: json["doctor_profile_is_active"],
    doctorProfileCreatedUserId: json["doctor_profile_created_user_id"],
    doctorProfileCreatedDateTime: DateTime.parse(json["doctor_profile_created_date_time"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "doctor_profile_id": doctorProfileId,
    "doctor_profile_name": doctorProfileName,
    "doctor_profile_degree": doctorProfileDegree,
    "doctor_profile_additional_info": doctorProfileAdditionalInfo,
    "doctor_profile_image": doctorProfileImage,
    "doctor_profile_mobile_number": doctorProfileMobileNumber,
    "doctor_profile_password": doctorProfilePassword,
    "doctor_profile_specialities_name": doctorProfileSpecialitiesName,
    "doctor_consultation_fee": doctorConsultationFee,
    "doctor_profile_hospital_location_name": doctorProfileHospitalLocationName,
    "doctor_specialities_id": doctorSpecialitiesId,
    "hospital_location_id": hospitalLocationId,
    "doctor_profile_is_active": doctorProfileIsActive,
    "doctor_profile_created_user_id": doctorProfileCreatedUserId,
    "doctor_profile_created_date_time": doctorProfileCreatedDateTime?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
