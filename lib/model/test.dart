/// status : true
/// message : "Doctor Slot Found In Our System"
/// data : [{"doctor_time_slot_id":16,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"12:00 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"},{"doctor_time_slot_id":17,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"12:20 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"},{"doctor_time_slot_id":18,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"01:20 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"},{"doctor_time_slot_id":19,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"02:40 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"},{"doctor_time_slot_id":20,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"12:00 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"},{"doctor_time_slot_id":21,"doctor_profile_id":1,"doctor_slot_date":"2023-01-21","doctor_slot_time":"12:00 AM","doctor_slot_time_is_booked":"no","doctor_slot_time_booked_time":null,"doctor_slot_time_booked_apps_user_id":null,"doctor_slot_time_added_user_id":1,"created_at":"2023-01-19T06:53:23.000000Z","updated_at":"2023-01-19T06:53:23.000000Z"}]
/// status_code : 200

class Test {
  Test({
    bool? status,
    String? message,
    List<Data>? data,
    int? statusCode,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _statusCode = statusCode;
  }

  Test.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _statusCode = json['status_code'];
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  int? _statusCode;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;
  int? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status_code'] = _statusCode;
    return map;
  }
}

/// doctor_time_slot_id : 16
/// doctor_profile_id : 1
/// doctor_slot_date : "2023-01-21"
/// doctor_slot_time : "12:00 AM"
/// doctor_slot_time_is_booked : "no"
/// doctor_slot_time_booked_time : null
/// doctor_slot_time_booked_apps_user_id : null
/// doctor_slot_time_added_user_id : 1
/// created_at : "2023-01-19T06:53:23.000000Z"
/// updated_at : "2023-01-19T06:53:23.000000Z"

class Data {
  Data({
    int? doctorTimeSlotId,
    int? doctorProfileId,
    String? doctorSlotDate,
    String? doctorSlotTime,
    String? doctorSlotTimeIsBooked,
    dynamic doctorSlotTimeBookedTime,
    dynamic doctorSlotTimeBookedAppsUserId,
    int? doctorSlotTimeAddedUserId,
    String? createdAt,
    String? updatedAt,
  }) {
    _doctorTimeSlotId = doctorTimeSlotId;
    _doctorProfileId = doctorProfileId;
    _doctorSlotDate = doctorSlotDate;
    _doctorSlotTime = doctorSlotTime;
    _doctorSlotTimeIsBooked = doctorSlotTimeIsBooked;
    _doctorSlotTimeBookedTime = doctorSlotTimeBookedTime;
    _doctorSlotTimeBookedAppsUserId = doctorSlotTimeBookedAppsUserId;
    _doctorSlotTimeAddedUserId = doctorSlotTimeAddedUserId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _doctorTimeSlotId = json['doctor_time_slot_id'];
    _doctorProfileId = json['doctor_profile_id'];
    _doctorSlotDate = json['doctor_slot_date'];
    _doctorSlotTime = json['doctor_slot_time'];
    _doctorSlotTimeIsBooked = json['doctor_slot_time_is_booked'];
    _doctorSlotTimeBookedTime = json['doctor_slot_time_booked_time'];
    _doctorSlotTimeBookedAppsUserId =
        json['doctor_slot_time_booked_apps_user_id'];
    _doctorSlotTimeAddedUserId = json['doctor_slot_time_added_user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _doctorTimeSlotId;
  int? _doctorProfileId;
  String? _doctorSlotDate;
  String? _doctorSlotTime;
  String? _doctorSlotTimeIsBooked;
  dynamic _doctorSlotTimeBookedTime;
  dynamic _doctorSlotTimeBookedAppsUserId;
  int? _doctorSlotTimeAddedUserId;
  String? _createdAt;
  String? _updatedAt;

  int? get doctorTimeSlotId => _doctorTimeSlotId;
  int? get doctorProfileId => _doctorProfileId;
  String? get doctorSlotDate => _doctorSlotDate;
  String? get doctorSlotTime => _doctorSlotTime;
  String? get doctorSlotTimeIsBooked => _doctorSlotTimeIsBooked;
  dynamic get doctorSlotTimeBookedTime => _doctorSlotTimeBookedTime;
  dynamic get doctorSlotTimeBookedAppsUserId => _doctorSlotTimeBookedAppsUserId;
  int? get doctorSlotTimeAddedUserId => _doctorSlotTimeAddedUserId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_time_slot_id'] = _doctorTimeSlotId;
    map['doctor_profile_id'] = _doctorProfileId;
    map['doctor_slot_date'] = _doctorSlotDate;
    map['doctor_slot_time'] = _doctorSlotTime;
    map['doctor_slot_time_is_booked'] = _doctorSlotTimeIsBooked;
    map['doctor_slot_time_booked_time'] = _doctorSlotTimeBookedTime;
    map['doctor_slot_time_booked_apps_user_id'] =
        _doctorSlotTimeBookedAppsUserId;
    map['doctor_slot_time_added_user_id'] = _doctorSlotTimeAddedUserId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
