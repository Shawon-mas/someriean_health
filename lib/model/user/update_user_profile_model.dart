// To parse this JSON data, do
//
//     final updateUserProfileModel = updateUserProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateUserProfileModel? updateUserProfileModelFromJson(String str) => UpdateUserProfileModel.fromJson(json.decode(str));

String updateUserProfileModelToJson(UpdateUserProfileModel? data) => json.encode(data!.toJson());

class UpdateUserProfileModel {
  UpdateUserProfileModel({
    required this.status,
    required this.data,
    required this.message,
    required this.statusCode,
  });

  bool? status;
  Data? data;
  String? message;
  int? statusCode;

  factory UpdateUserProfileModel.fromJson(Map<String, dynamic> json) => UpdateUserProfileModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
    "message": message,
    "status_code": statusCode,
  };
}

class Data {
  Data({
    required this.appsUserId,
    required this.appsUserFirstName,
    required this.appsUserLastName,
    required this.appsUserDob,
    required this.appsUserMobileNumber,
    required this.appsUserEmail,
    required this.appsUserGender,
    required this.appsUserNationality,
    required this.appsUserProfilePic,
    required this.appsUserEmiratesIdNumber,
    required this.appsUserEmiratesIdFrontPic,
    required this.appsUserEmiratesIdBackPic,
    required this.appsUserPassportPic,
    required this.appsUserVisaPic,
    required this.appsUserInsurancePic,
    required this.appsUserOthersFile,
    required this.appsUserActiveStatus,
    required this.appsUserCreatedDateTime,
    required this.createdAt,
    required this.updatedAt,
  });

  int? appsUserId;
  String? appsUserFirstName;
  String? appsUserLastName;
  DateTime? appsUserDob;
  String? appsUserMobileNumber;
  String? appsUserEmail;
  String? appsUserGender;
  String? appsUserNationality;
  dynamic appsUserProfilePic;
  String? appsUserEmiratesIdNumber;
  dynamic appsUserEmiratesIdFrontPic;
  dynamic appsUserEmiratesIdBackPic;
  dynamic appsUserPassportPic;
  dynamic appsUserVisaPic;
  dynamic appsUserInsurancePic;
  dynamic appsUserOthersFile;
  String? appsUserActiveStatus;
  DateTime? appsUserCreatedDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appsUserId: json["apps_user_id"],
    appsUserFirstName: json["apps_user_first_name"],
    appsUserLastName: json["apps_user_last_name"],
    appsUserDob: DateTime.parse(json["apps_user_dob"]),
    appsUserMobileNumber: json["apps_user_mobile_number"],
    appsUserEmail: json["apps_user_email"],
    appsUserGender: json["apps_user_gender"],
    appsUserNationality: json["apps_user_nationality"],
    appsUserProfilePic: json["apps_user_profile_pic"],
    appsUserEmiratesIdNumber: json["apps_user_emirates_id_number"],
    appsUserEmiratesIdFrontPic: json["apps_user_emirates_id_front_pic"],
    appsUserEmiratesIdBackPic: json["apps_user_emirates_id_back_pic"],
    appsUserPassportPic: json["apps_user_passport_pic"],
    appsUserVisaPic: json["apps_user_visa_pic"],
    appsUserInsurancePic: json["apps_user_insurance_pic"],
    appsUserOthersFile: json["apps_user_others_file"],
    appsUserActiveStatus: json["apps_user_active_status"],
    appsUserCreatedDateTime: DateTime.parse(json["apps_user_created_date_time"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "apps_user_id": appsUserId,
    "apps_user_first_name": appsUserFirstName,
    "apps_user_last_name": appsUserLastName,
    "apps_user_dob": "${appsUserDob!.year.toString().padLeft(4, '0')}-${appsUserDob!.month.toString().padLeft(2, '0')}-${appsUserDob!.day.toString().padLeft(2, '0')}",
    "apps_user_mobile_number": appsUserMobileNumber,
    "apps_user_email": appsUserEmail,
    "apps_user_gender": appsUserGender,
    "apps_user_nationality": appsUserNationality,
    "apps_user_profile_pic": appsUserProfilePic,
    "apps_user_emirates_id_number": appsUserEmiratesIdNumber,
    "apps_user_emirates_id_front_pic": appsUserEmiratesIdFrontPic,
    "apps_user_emirates_id_back_pic": appsUserEmiratesIdBackPic,
    "apps_user_passport_pic": appsUserPassportPic,
    "apps_user_visa_pic": appsUserVisaPic,
    "apps_user_insurance_pic": appsUserInsurancePic,
    "apps_user_others_file": appsUserOthersFile,
    "apps_user_active_status": appsUserActiveStatus,
    "apps_user_created_date_time": appsUserCreatedDateTime?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
