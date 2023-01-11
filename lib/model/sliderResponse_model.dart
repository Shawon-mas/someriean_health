// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel? sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel? data) => json.encode(data!.toJson());

class SliderModel {
  SliderModel({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  bool? status;
  String? message;
  List<Datum?>? data;
  int? statusCode;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    "status_code": statusCode,
  };
}

class Datum {
  Datum({
    this.sliderImageId,
    this.sliderImagePath,
    this.sliderImageTitle,
    this.sliderImageLink,
    this.sliderImageUploadUserId,
    this.sliderImageStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? sliderImageId;
  String? sliderImagePath;
  String? sliderImageTitle;
  dynamic sliderImageLink;
  int? sliderImageUploadUserId;
  int? sliderImageStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sliderImageId: json["slider_image_id"],
    sliderImagePath: json["slider_image_path"],
    sliderImageTitle: json["slider_image_title"],
    sliderImageLink: json["slider_image_link"],
    sliderImageUploadUserId: json["slider_image_upload_user_id"],
    sliderImageStatus: json["slider_image_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "slider_image_id": sliderImageId,
    "slider_image_path": sliderImagePath,
    "slider_image_title": sliderImageTitle,
    "slider_image_link": sliderImageLink,
    "slider_image_upload_user_id": sliderImageUploadUserId,
    "slider_image_status": sliderImageStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
