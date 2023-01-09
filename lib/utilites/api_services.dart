import 'package:somerian_health/utilites/shared_prefs.dart';

class ApiServices{

static const String BASE_URL='https://somerian-app.noman-it.com/api';
static const String OTP_URL=BASE_URL+'/User/UserOTP';
static const String OTP_URL_LOGIN=BASE_URL+'/User/UserCheckByNumber';
static const String USER_UPDATE_URL=BASE_URL+'/User/UpdateUserProfile';

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
  //user profile
  static const String USER_ID='apps_user_id';
  static const String USER_FIRST_NAME='apps_user_first_name';
  static const String USER_LAST_NAME='apps_user_last_name';
  static const String USER_DOB='apps_user_dob';
  static const String USER_EMAIL='apps_user_email';
  static const String USER_GENDER='apps_user_gender';
  static const String USER_NATIONALITY='apps_user_nationality';
  static const String USER_EMIRATES_ID='apps_user_emirates_id_number';
}
