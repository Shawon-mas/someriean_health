import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  PlatformFile? platformFile;
  var user = FirebaseAuth.instance.currentUser;

  Future selectFile(
      {required BuildContext context, required String docName}) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    uploadFile(
        path: result.files.single.path!, context: context, docName: docName);
  }

  uploadFile(
      {required String path,
      required BuildContext context,
      required String docName}) async {
    //dialog
    showBottom(context, "Your file is uploading");
    // infoSnackBar(context, "Uploading file");
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child(user!.phoneNumber! + "/" + basename(path));
    final uploadTask = await fileRef.putFile(File(path));
    String url = await uploadTask.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection(DbCollections.collectionPatients)
        .doc(user!.phoneNumber!)
        .set({
      docName: url,
    }, SetOptions(merge: true)).then((value) {
      Navigator.pop(context);
      successSnackBar(context, "Upload Successful");
    });
  }

  deleteFile(
      {required String url,
      required BuildContext context,
      required String docName}) {
    //Call a dialog while uploading
    showBottom(context, "Deleting File");
    final storageRef = FirebaseStorage.instance.refFromURL(url);
    storageRef.delete().then((value) {
      FirebaseFirestore.instance
          .collection(DbCollections.collectionPatients)
          .doc(user!.phoneNumber!)
          .set({
        docName: "",
      }, SetOptions(merge: true)).then((value) {
        Navigator.pop(context);
        successSnackBar(context, "Deleted File");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(DoctorAppointmentController());
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(DbCollections.collectionPatients)
          .doc(user!.phoneNumber!)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextWidget(
                      value: 'Emirates ID',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      textColor: Properties.colorTextBlue,
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        uploadFunction(
                          snapshot: snapshot,
                          name: "Upload Front Copy",
                          docName: DbDocs.fieldFrontCopy,
                          context: context,
                        ),
                        uploadFunction(
                          snapshot: snapshot,
                          name: "Upload Back Copy",
                          docName: DbDocs.fieldBackCopy,
                          context: context,
                        ),
                      ],
                    ))
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        value: 'Passport',
                        size: 16.sp,
                        fontWeight: FontWeight.bold,
                        textColor: Properties.colorTextBlue,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          uploadFunction(
                            snapshot: snapshot,
                            name: "Upload",
                            docName: DbDocs.fieldPassportCopy,
                            context: context,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: TextWidget(
                      value: 'Visa',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      textColor: Properties.colorTextBlue,
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        uploadFunction(
                          snapshot: snapshot,
                          name: "Upload",
                          docName: DbDocs.fieldVisa,
                          context: context,
                        ),
                      ],
                    ))
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: TextWidget(
                      value: 'Insurance',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      textColor: Properties.colorTextBlue,
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        uploadFunction(
                          snapshot: snapshot,
                          name: "Upload",
                          docName: DbDocs.fieldInsurance,
                          context: context,
                        ),
                      ],
                    ))
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: TextWidget(
                      value: 'Others',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                      textColor: Properties.colorTextBlue,
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        uploadFunction(
                          snapshot: snapshot,
                          name: "Upload",
                          docName: DbDocs.fieldOthers,
                          context: context,
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget uploadFunction(
      {required AsyncSnapshot<DocumentSnapshot<Object?>> snapshot,
      required BuildContext context,
      required String docName,
      required String name}) {
    return !checkFileExists(snapshot: snapshot, dbDocs: docName)
        ? _uploadButton(context: context, docName: docName, name: name)
        : _uploaded(context: context, snapshot: snapshot, docName: docName);
  }

  bool checkFileExists(
      {required AsyncSnapshot<DocumentSnapshot<Object?>> snapshot,
      required String dbDocs}) {
    if (!(snapshot.data!.data() as Map<String, dynamic>).containsKey(dbDocs)) {
      return false;
    } else if (snapshot.data!.get(dbDocs) == "") {
      return false;
    } else {
      return true;
    }
  }

  Widget _uploaded(
      {required AsyncSnapshot<DocumentSnapshot<Object?>> snapshot,
      required BuildContext context,
      required String docName}) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(snapshot.data!.get(docName)))) {
                launchUrl(
                  Uri.parse(snapshot.data!.get(docName)),
                  mode: LaunchMode.externalNonBrowserApplication,
                );
              }
            },
            child: Text(
              getFileName(snapshot.data!.get(docName)),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              deleteFile(
                url: snapshot.data!.get(docName),
                context: context,
                docName: docName,
              );
            },
            icon: Icon(
              Icons.cancel,
            ),
          ),
        ),
      ],
    );
  }

  Widget _uploadButton(
      {required BuildContext context,
      required String name,
      required String docName}) {
    return AppointmentButton(
      onPressed: () {
        selectFile(context: context, docName: docName);
      },
      value: name,
    );
  }

  void showBottom(BuildContext context, String title) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200.h,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    textColor: Properties.colorTextBlue,
                    value: title,
                    textAlign: TextAlign.center,
                    size: 20.sp,
                    fontWeight: FontWeight.w700,
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}

String getFileName(String url) {
  RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');

  var matches = regExp.allMatches(url);
  var match = matches.elementAt(0);

  print("${Uri.decodeFull(match.group(2)!)}");
  return Uri.decodeFull(match.group(2)!);
}
