import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../global/properties.dart';
import '../model/user/update_user_profile_model.dart';
import '../utilites/api_services.dart';
import '../utilites/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../view/widget/text_widget.dart';
class DocumentController extends GetxController{
  final image = XFile("").obs;
  final imagePath = "".obs;
  var emiratesFront=''.obs;
  var emiratesBack=''.obs;
  var passport=''.obs;
  var visa=''.obs;
  var insurance=''.obs;
  var others=''.obs;




  pickEfImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putEfImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putEfImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putEfImageToServer(String path) async{
  //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_EMIRATES_FRONT_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_EMIRATES_FRONT_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserEmiratesIdFrontPic!);
    _getUserData();
    Get.back();
  }

  pickEbImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putEbImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putEbImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putEbImageToServer(String path) async{
    //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_EMIRATES_BACK_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_EMIRATES_BACK_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserEmiratesIdBackPic!);
    _getUserData();
    Get.back();
  }

  pickPassportImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putPassportImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putPassportImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putPassportImageToServer(String path) async{
    //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_PASSPORT_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_PASSPORT_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserPassportPic!);
    _getUserData();
    Get.back();
  }

  pickVisaImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putVisaImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putVisaImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putVisaImageToServer(String path) async{
    //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_VISA_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_VISA_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserVisaPic!);
    _getUserData();
    Get.back();
  }

  pickInsuranceImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putInsuranceImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putInsuranceImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putInsuranceImageToServer(String path) async{
    //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_INSURANCE_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_INSURANCE_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserInsurancePic!);
    _getUserData();
    Get.back();
  }

  pickOthersImage() {
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: const Text("Choose from gallery"),
            leading: const Icon(
              Icons.photo_size_select_actual_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putOthersImageToServer(photo.path);
                //   uploadPhoto();
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Capture image"),
            leading: const Icon(
              Icons.camera_rounded,
              color: Properties.primaryColor,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
              await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                image.value = photo;
                imagePath.value = photo.path;
                _putOthersImageToServer(photo.path);
              } else {
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
  _putOthersImageToServer(String path) async{
    //await SharedPrefs().getUserId()
    Get.back();
    showBottom();
    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_OTHER_PICTURE));
    File _file = File(path);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile(ApiKeyName.USER_PROFILE_OTHERS_PICTURE, _fileStream, _fileLength, filename: (_file.path));
    _request.fields["apps_user_id"] = await SharedPrefs().getUserId();
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);
    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    print(pictureUploaded!.data!.appsUserOthersFile!);
    _getUserData();
    Get.back();
  }

  _getUserData()async {

    Map<String,dynamic> body={
      ApiKeyName.OTP_NUMBER:await SharedPrefs().getUserNumber(),
    };
    try{
      var response=await http.post(Uri.parse(ApiServices.OTP_URL_LOGIN),
          body: body,
          headers: ApiServices().defaultHeader
      );
      if(response.statusCode==200){
        final updateUserProfileModel = updateUserProfileModelFromJson(response.body);
        if (updateUserProfileModel!.status! && updateUserProfileModel.data != null) {

          /*Get all data*/
          await SharedPrefs().generalStoreData(value: response.body, key: "user_data");
          String? jsonData = await SharedPrefs().generalGetData(key: "user_data");
          if (jsonData != null) {
            final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
                emiratesFront.value=updateUserProfileModel!.data!.appsUserEmiratesIdFrontPic!;
                emiratesBack.value=updateUserProfileModel.data!.appsUserEmiratesIdBackPic!;
                passport.value=updateUserProfileModel.data!.appsUserPassportPic!;
                visa.value=updateUserProfileModel.data!.appsUserVisaPic!;
                insurance.value=updateUserProfileModel.data!.appsUserInsurancePic!;
                others.value=updateUserProfileModel.data!.appsUserOthersFile!;

          }
        }

      }

    }catch(e){

      if (kDebugMode) {
        print(e.toString());
      }
    }

  }



  @override
  void onInit() {
    // TODO: implement onInit
    _getUserData();
    super.onInit();
  }

  void showBottom() {
    Get.bottomSheet(
      Container(
          height: 150,
          color: Colors.white,
          child:Column(
            children: [
              Text('Your file is uploading', textScaleFactor: 2),
              CircularProgressIndicator(),
            ],
          )
      ),
      barrierColor: Colors.red[50],
      isDismissible: false,
    );
  }


}