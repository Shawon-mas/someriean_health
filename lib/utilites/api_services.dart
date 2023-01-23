import 'package:somerian_health/utilites/shared_prefs.dart';

class ApiServices{

static const String BASE_URL='https://appointment.somerianhealth.com/api';
static const String IMAGE_BASE_URL='https://appointment.somerianhealth.com/public/';
//auth url
static const String OTP_URL=BASE_URL+'/User/UserOTP';
static const String OTP_URL_LOGIN=BASE_URL+'/User/UserCheckByNumber';
static const String USER_UPDATE_URL=BASE_URL+'/User/UpdateUserProfile';
//image url
static const String USER_UPDATE_PROFILE_PICTURE=BASE_URL+'/User/UpdateUserImage';
static const String USER_UPDATE_PROFILE_EMIRATES_FRONT_PICTURE=BASE_URL+'/User/UpdateUserEmiratesFrontImage';
static const String USER_UPDATE_PROFILE_EMIRATES_BACK_PICTURE=BASE_URL+'/User/UpdateUserEmiratesBackImage';
static const String USER_UPDATE_PROFILE_PASSPORT_PICTURE=BASE_URL+'/User/UpdateUserPassportImage';
static const String USER_UPDATE_PROFILE_VISA_PICTURE=BASE_URL+'/User/UpdateUserVisaImage';
static const String USER_UPDATE_PROFILE_INSURANCE_PICTURE=BASE_URL+'/User/UpdateUserInsuranceImage';
static const String USER_UPDATE_PROFILE_OTHER_PICTURE=BASE_URL+'/User/UpdateUserOthersFile';
//slider url
  static const String SLIDER_URL=BASE_URL+'/GetAllActiveSliderImage';

  //doctor url
  static const String SPECIALIST_URL=BASE_URL+'/GetAllActiveDoctorSpecialities';
  static const String DOCTOR_BY_SPECIALIST_URL=BASE_URL+'/GetAllDoctorProfileBySpecialitiesID';
  static const String LOCATION_URL=BASE_URL+'/GetAllActiveHospitalLocation';
  static const String DOCTOR_PROFILE_URL=BASE_URL+'/GetAllActiveDoctorProfileData';
  static const String HOSPITAL_BY_DOCTOR_PROFILE_URL=BASE_URL+'/GetAllDoctorProfileByHospitalID';

  //doctor appointment url
  static const String DOCTOR_APPOINTMENT_URL=BASE_URL+'/Booking/AddDoctorAppointment';
  static const String DOCTOR_APPOINTMENT_LIST_URL=BASE_URL+'/Booking/AllDoctorAppointmentListByUserID';

  //Doctor Time Slot By Doctor ID And DateDoctor Time Slot By Doctor ID And Date
  static const String DOCTOR_APPOINTMENT_SLOT_TIME=BASE_URL+'/Doctor/GetDoctorAllSlotByDocID';

  //health package
  static const String ALL_ACTIVE_HEALTH_PACKAGE=BASE_URL+'/Package/GetAllActiveHealthPackage';
  static const String HEALTH_PACKAGE_BOOKING=BASE_URL+'/Booking/AddHealthPackageBooking';

  //visa screening for residency
  static const String VISA_SCREENING_EMIRATES=BASE_URL+'/GetAllVisaScreeningEmirate';
  static const String VISA_SCREENING_PACKAGES=BASE_URL+'/GetAllVisaScreeningPackage';
  static const String RESIDENCY_VISA_SCREENING_BOOKINGS=BASE_URL+'/Visa/AddVisaScreeningBooking';

  Map<String, String> defaultHeader = {
    'Accept': 'application/json',
  };

Future<Map<String, String>> headerWithToken() async{
    var getHeaderWithToken = {
    'Accept':'application/json',
    'Authorization':'${await SharedPrefs().getToken()}'
  };
    return getHeaderWithToken;

  }

}
class ApiKeyName{
  //otp
  static const String OTP_NUMBER='number';
  //user profile key
  static const String USER_ID='apps_user_id';
  static const String USER_FIRST_NAME='apps_user_first_name';
  static const String USER_LAST_NAME='apps_user_last_name';
  static const String USER_DOB='apps_user_dob';
  static const String USER_EMAIL='apps_user_email';
  static const String USER_GENDER='apps_user_gender';
  static const String USER_NATIONALITY='apps_user_nationality';
  static const String USER_EMIRATES_ID='apps_user_emirates_id_number';
  //user image key
  static const String USER_PROFILE_PICTURE='apps_user_profile_pic';
  static const String USER_PROFILE_EMIRATES_FRONT_PICTURE='apps_user_emirates_id_front_pic';
  static const String USER_PROFILE_EMIRATES_BACK_PICTURE='apps_user_emirates_id_back_pic';
  static const String USER_PROFILE_PASSPORT_PICTURE='apps_user_passport_pic';
  static const String USER_PROFILE_VISA_PICTURE='apps_user_visa_pic';
  static const String USER_PROFILE_INSURANCE_PICTURE='apps_user_insurance_pic';
  static const String USER_PROFILE_OTHERS_PICTURE='apps_user_others_pic';

  //appointment key
  static const String DOCTOR_PROFILE_ID='doctor_profile_id';
  static const String DOCTOR_APPOINTMENT_APPS_USER_ID='doctor_appointment_apps_user_id';

  static const String DOCTOR_APPOINTMENT_PREFER_DATE='doctor_appointment_prefer_date';
  static const String DOCTOR_APPOINTMENT_PREFER_TIME='doctor_appointment_prefer_time';
  static const String DOCTOR_TIME_SLOT_ID='doctor_time_slot_id';
  static const String DOCTOR_APPOINTMENT_USER_FIRST_NAME='doctor_appointment_user_first_name';
  static const String DOCTOR_APPOINTMENT_USER_LAST_NAME='doctor_appointment_user_last_name';
  static const String DOCTOR_APPOINTMENT_USER_MOBILE_NUMBER='doctor_appointment_user_mobile_number';
  static const String DOCTOR_APPOINTMENT_USER_GENDER='doctor_appointment_user_gender';
  static const String DOCTOR_APPOINTMENT_USER_EMIRATES_ID='doctor_appointment_user_emirates_id';
  static const String DOCTOR_APPOINTMENT_USER_NATIONALITY='doctor_appointment_user_nationality';
  static const String DOCTOR_APPOINTMENT_BOOKING_FEE='doctor_appointment_booking_fee';
  static const String DOCTOR_APPOINTMENT_BOOK_IS_SELF='doctor_appointment_book_is_self';

  static const String DOCTOR_APPOINTMENT_OTHERS_USER_FULL_NAME='doctor_appointment_book_others_user_full_name';
  static const String DOCTOR_APPOINTMENT_OTHERS_USER_EMIRATES_ID='doctor_appointment_book_others_user_emirates_id';
  static const String DOCTOR_APPOINTMENT_OTHERS_USER_RELATIONSHIP='doctor_appointment_book_others_user_relationship';
  static const String DOCTOR_APPOINTMENT_OTHERS_USER_MOBILE_NUMBER='doctor_appointment_book_others_user_mobile_number';

  //doctor key

  static const String DOCTOR_BY_SPECIALIST='doctor_specialities_id';
  static const String DOCTOR_BY_LOCATION='hospital_location_id';
  static const String DOCTOR_DATE_SLOT='doctor_slot_date';

  //health package booking key
  static const String HOSPITAL_LOCATION_ID='hospital_location_id';
  static const String HEALTH_PACKAGE_ID='health_package_id';
  static const String HEALTH_PACKAGE_USER_ID='health_package_apps_user_id';
  static const String HEALTH_PACKAGE_BOOKING_USER_FIRST_NAME='health_package_booking_user_first_name';
  static const String HEALTH_PACKAGE_BOOKING_USER_LAST_NAME='health_package_booking_user_last_name';
  static const String HEALTH_PACKAGE_BOOKING_USER_NUMBER='health_package_booking_user_number';
  static const String HEALTH_PACKAGE_BOOKING_USER_GENDER='health_package_booking_user_gender';
  static const String HEALTH_PACKAGE_BOOKING_USER_EMAIL='health_package_booking_user_email_id';
  static const String HEALTH_PACKAGE_BOOKING_USER_NATIONALITY='health_package_booking_user_nationality';
  static const String HEALTH_PACKAGE_BOOKING_DATE='health_package_booking_prepable_date';
  static const String HEALTH_PACKAGE_BOOKING_TIME='health_package_booking_prepable_time';
  static const String HEALTH_PACKAGE_BOOKING_PRICE='health_package_booking_price';
  static const String HEALTH_PACKAGE_BOOKING_MESSAGE='health_package_booking_any_message';
  static const String HEALTH_PACKAGE_BOOKING_PAYMENT_METHOD='health_package_booking_payment_method';
  static const String HEALTH_PACKAGE_BOOKING_FOR_WHOM='health_package_booking_for_whom';
  static const String HEALTH_PACKAGE_BOOKING_FOR_COMPANY_NAME='health_package_booking_for_company_name';
  static const String HEALTH_PACKAGE_BOOKING_FOR_COMPANY_NUMBER='health_package_booking_for_company_number';
  static const String HEALTH_PACKAGE_BOOKING_FOR_COMPANY_EMAIL='health_package_booking_for_company_email';
  static const String HEALTH_PACKAGE_BOOKING_FOR_COMPANY_AUTH_PERSON='health_package_booking_for_company_authorized_person';
  static const String HEALTH_PACKAGE_BOOKING_FOR_COMPANY_ADDRESS='health_package_booking_for_company_address';

  //residency visa screening

  static const String VISA_SCREENING_TYPES_ID='visa_screening_service_type_id';
  static const String VISA_SCREENING_EMIRATES_ID='visa_screening_emirate_id';
  static const String VISA_SCREENING_PACKAGES_ID='visa_screening_package_id';
  static const String VISA_SCREENING_APP_USER_ID='visa_screening_apps_user_id';
  static const String VISA_SCREENING_APP_USER_FIRST_NAME='visa_screening_user_first_name';
  static const String VISA_SCREENING_APP_USER_LAST_NAME='visa_screening_user_last_name';
  static const String VISA_SCREENING_APP_USER_DOB='visa_screening_user_birth_date';
  static const String VISA_SCREENING_APP_USER_GENDER='visa_screening_user_gender';
  static const String VISA_SCREENING_APP_USER_EMAIL='visa_screening_user_email';
  static const String VISA_SCREENING_APP_USER_PHONE_NUMBER='visa_screening_user_phone_number';
  static const String VISA_SCREENING_APP_USER_VISA_TYPE='visa_screening_user_visa_type';
  static const String VISA_SCREENING_APP_USER_BOOKING_DATE='visa_screening_user_prepared_date';
  static const String VISA_SCREENING_APP_USER_BOOKING_TIME='visa_screening_user_prepared_time';
  static const String VISA_SCREENING_APP_USER_PAYMENT_TYPE='visa_screening_user_payment_type';

}
