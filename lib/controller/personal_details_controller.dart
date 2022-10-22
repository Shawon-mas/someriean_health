import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:path/path.dart';
import 'package:somerian_health/global/global_constants.dart';
import '../global/properties.dart';

class PersonalDetailsController extends GetxController {
  var imagePath = "".obs;
  var selectedImagePath = "";
  var isImageUploading = false.obs;
  var isEditable = false.obs;
  var user = FirebaseAuth.instance.currentUser;
  var dobController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var genderController = TextEditingController();
  var nationalityController = TextEditingController();
  var emiratesIdController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    selectedDate.value = picked!;
    dobController.text =
        '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
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
                selectedImagePath = photo.path;
                uploadPhoto();
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
                selectedImagePath = photo.path;
                uploadPhoto();
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
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }
}
