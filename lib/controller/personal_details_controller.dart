import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:path/path.dart';
import 'package:somerian_health/global/global_constants.dart';
import '../global/properties.dart';
import '../model/user/update_user_profile_model.dart';
import '../utilites/api_services.dart';
import '../utilites/response_repository.dart';
import '../utilites/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../view/screens/bottom_screens/menu.dart';

class PersonalDetailsController extends GetxController {
  final image = XFile("").obs;
  final imagePath = "".obs;
  final selectImagePath = "".obs;
  final _box = Hive.box(hiveBox);
  var selectedImagePath = "";
  var selectedImage = "".obs;
  var isImageUploading = false.obs;
  var isEditable = false.obs;
  var isUpdated = false.obs;
  var user = FirebaseAuth.instance.currentUser;
  var isUploading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var dobController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var genderController = TextEditingController();
  var nationalityController = TextEditingController();
  var emiratesIdController = TextEditingController();
  var typeMessageController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
    dobController.text =
    '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}';
  }


  checkFieldCheck(BuildContext context) {
    if (firstNameController.text.toString().isEmpty) {
      //getErrorSnack('First Name Required');
      errorSnackBar(context, "First Name Required");
    } else if (lastNameController.text.toString().isEmpty) {
      errorSnackBar(context, "Last Name Required");
    } else if (dobController.text.toString().isEmpty) {
      errorSnackBar(context, "Date of Birth Required");
    } else if (mobileController.text.toString().isEmpty) {
      errorSnackBar(context, "Mobile Number Required");
    } else if (emailController.text.toString().isEmpty) {
      errorSnackBar(context, "Email Required");
    } else if (genderController.text.toString().isEmpty) {
      errorSnackBar(context, "Gender Required");
    } else if (nationalityController.text.toString().isEmpty) {
      errorSnackBar(context, "Nationality Required");
    }  else if (emiratesIdController.text.toString().isEmpty) {
      errorSnackBar(context, "Emirates ID Required");
    }
    else {
      _submitProfileNew(context);
    }
  }
  _submitProfileNew(context) async {
    isUploading.value = true;
   // var dob = '${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}';

    Map<String, dynamic> body = {
      ApiKeyName.USER_ID: await SharedPrefs().getUserId(),
      ApiKeyName.USER_FIRST_NAME: firstNameController.text,
      ApiKeyName.USER_LAST_NAME: lastNameController.text,
      ApiKeyName.USER_DOB: dobController.text,
      ApiKeyName.USER_EMAIL: emailController.text.toString(),
      ApiKeyName.USER_GENDER: genderController.text.toString(),
      ApiKeyName.USER_NATIONALITY: nationalityController.text.toString(),
      ApiKeyName.USER_EMIRATES_ID: emiratesIdController.text,
    };

    var response = await authPost(url: ApiServices.USER_UPDATE_URL, body: body);
    if (response != null) {
      try {
        final updateUserProfileModel = updateUserProfileModelFromJson(response.body);
        if (updateUserProfileModel!.status! && updateUserProfileModel.data != null) {

          /*Get all data*/
          //  await SharedPrefs().generalStoreData(value: response.body, key: "user_data");
     /*     await SharedPrefs().isLogin(true);
          print(await SharedPrefs().getIsLogin());*/

          /* String? jsonData = await SharedPrefs().generalGetData(key: "user_data");
          if (jsonData != null) {
            final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
            print(updateUserProfileModel);

          }*/
          Get.to(()=>MenuScreen());
          isUploading.value = false;
          successSnackBar(context, "Submitted successfully");
        }
        /*Do the rest*/
      } catch (e) {
        isUploading.value = false;
        /*Handle error*/
      }
    }
  }

  getUserData()async{
    String? jsonData = await SharedPrefs().generalGetData(key:"user_data");
    if (jsonData != null) {
      final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
      firstNameController.text = updateUserProfileModel!.data!.appsUserFirstName!;
      lastNameController.text = updateUserProfileModel.data!.appsUserLastName!;
      mobileController.text = updateUserProfileModel.data!.appsUserMobileNumber!;
      emailController.text = updateUserProfileModel.data!.appsUserEmail!;
      genderController.text = updateUserProfileModel.data!.appsUserGender!;
      nationalityController.text = updateUserProfileModel.data!.appsUserNationality!;
      emiratesIdController.text = updateUserProfileModel.data!.appsUserEmiratesIdNumber!;
      dobController.text = '${updateUserProfileModel.data!.appsUserDob!.year.toString()}-${updateUserProfileModel.data!.appsUserDob!.month.toString()}-${updateUserProfileModel.data!.appsUserDob!.day.toString()}';
      selectImagePath.value=ApiServices.IMAGE_BASE_URL+updateUserProfileModel.data!.appsUserProfilePic!;
    }
  }

  pickImage() {
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
                _putImageToServer(photo.path);
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
                _putImageToServer(photo.path);
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

  _putImageToServer(String imagePath) async{

    Get.back();
    isImageUploading.value = true;
    var user_id;
    String? jsonData = await SharedPrefs().generalGetData(key: "user_data");

    if (jsonData != null)
    {
      final updateUserProfileModel = updateUserProfileModelFromJson(jsonData);
       user_id = updateUserProfileModel!.data!.appsUserId!.toString();

    }

    var _request = http.MultipartRequest("POST", Uri.parse(ApiServices.USER_UPDATE_PROFILE_PICTURE));
    File _file = File(imagePath);
    var _fileStream = http.ByteStream(_file.openRead()..cast());
    var _fileLength = await _file.length();
    var _fileFile = http.MultipartFile('apps_user_profile_pic', _fileStream, _fileLength, filename: basename(_file.path));
    _request.fields["apps_user_id"] = user_id;
    _request.headers.addAll(await ApiServices().headerWithToken());
    _request.files.add(_fileFile);

    var _response = await _request.send();
    var respond= await http.Response.fromStream(_response);
    final pictureUploaded = updateUserProfileModelFromJson(respond.body);
    isImageUploading.value = false;
    await SharedPrefs().storeProfilePath('${ApiServices.IMAGE_BASE_URL}/${pictureUploaded!.data!.appsUserProfilePic!}');
    selectImagePath.value= await SharedPrefs().getProfilePath();
   // selectImagePath.value=pictureUploaded!.data!.appsUserProfilePic!;
    //ApiServices.IMAGE_BASE_URL+pictureUploaded!.data!.appsUserProfilePic!
    print(pictureUploaded.data!.appsUserProfilePic!);

  }



  uploadPhoto() async {
    Get.back();
    isImageUploading.value = true;
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef
        .child(user!.phoneNumber! + "/" + basename(selectedImagePath));
    final uploadTask = await fileRef.putFile(File(selectedImagePath));
    String url = await uploadTask.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(user!.phoneNumber!)
        .set({
      DbDocs.fieldImageUrl: url,
    }, SetOptions(merge: true)).then((value) async {
      isImageUploading.value = false;
      String oldPicUrl = imagePath.value;
      imagePath.value = url;
      if (oldPicUrl != "") {
        logger.d(oldPicUrl);
        await FirebaseStorage.instance.refFromURL(oldPicUrl).delete();
      }
    });
    _box.put(isProfileUpdated, true);
  }

  getUserInfo() {
    FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(user!.phoneNumber)
        .get()
        .then((value) {
      firstNameController.text = value[DbDocs.fieldFirstName];
      lastNameController.text = value[DbDocs.fieldLastName];
      dobController.text = value[DbDocs.fieldDob];
      mobileController.text = user!.phoneNumber!;
      emailController.text = value[DbDocs.fieldEmail];
      genderController.text = value[DbDocs.fieldGender];
      nationalityController.text = value[DbDocs.fieldNationality];
      if (value.data()!.containsKey(DbDocs.fieldEmiratesId)) {
        emiratesIdController.text = value[DbDocs.fieldEmiratesId];
      }
      if (value.data()!.containsKey(DbDocs.fieldImageUrl)) {
        imagePath.value = value[DbDocs.fieldImageUrl];
      } else {
        imagePath.value = "";
      }
    });
  }

  updateInfo(BuildContext context) {
    FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(user!.phoneNumber!)
        .set({
      DbDocs.fieldFirstName: firstNameController.text,
      DbDocs.fieldLastName: lastNameController.text,
      DbDocs.fieldDob: dobController.text,
      DbDocs.fieldEmail: emailController.text,
      DbDocs.fieldGender: genderController.text,
      DbDocs.fieldNationality: nationalityController.text,
      DbDocs.fieldEmiratesId: emiratesIdController.text,
      DbDocs.fieldImageUrl: imagePath.value,
      DbDocs.fieldDobMillSec:
          selectedDate.value.microsecondsSinceEpoch.toString(),
    }, SetOptions(merge: true)).then((value) {
      successSnackBar(context, "Information Updated");
      getUserInfo();
    });
    _box.put(isProfileUpdated, true);
  }

  saveMessage(String title, BuildContext context) {
    FirebaseFirestore.instance
        .collection(title.toLowerCase().replaceAll(" ", "_"))
        .doc()
        .set({
      DbDocs.fieldPatientNumber: mobileController.text,
      DbDocs.fieldMessage: typeMessageController.text,
    }).then((value) {
      typeMessageController.text = "";
      successSnackBar(context, "Thank you for being with us");
      Get.back();
    });
  }

  @override
  void onInit() async{
    getUserData();
    selectImagePath.value= await SharedPrefs().getProfilePath();
  //  getUserInfo();
    super.onInit();
  }
}
