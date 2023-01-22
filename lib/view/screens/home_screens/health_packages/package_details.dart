import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:somerian_health/view/screens/home_screens/health_packages/book_health_package_screen.dart';

import '../../../../controller/healthcare_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class PackageDetails extends StatelessWidget {
  final HealthcareController controller;
  const PackageDetails({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final CollectionReference _packages_details = FirebaseFirestore.instance
        .collection(DbCollections.collectionHealthPackages)
        .doc(docId)
        .collection(DbCollections.collectionHealthPackagesDetails);*/

    return Scaffold(
      appBar: CommonToolbar(title: controller.selectedPackage.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.h,
              child: Stack(
                children: [
                  Image.network(
                    controller.selectedPackage.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextWidget(
                          value: controller.selectedPackage.name,
                          size: 18.sp,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white60,
                            Properties.primaryColor,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            TextWidget(
              value: controller.selectedPackage.title,
              size: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: Properties.colorTextBlue,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Html(data: controller.selectedPackage.details),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: AppointmentButton(
          onPressed: () {
            Get.to(
              () => BookHealthCarePackageScreen(
                controller: controller,
              ),
            );
          },
          value: 'Book Now',
        ),
      ),
    );
  }

  void showPackageDetails(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Html(data: documentSnapshot['details']),
                  AppointmentButton(
                    onPressed: () {
                      /*Get.to(
                        () => BookHealthCarePackageScreen(
                          uid: documentSnapshot.id,
                          price: documentSnapshot['price'],
                          healthCareId: docId,
                        ),
                      );*/
                    },
                    value: 'Book Now',
                  ),
                  SizedBox(
                    height: 20,
                  )
                  /*  TextWidget(
                  value: documentSnapshot['details'],
                  size: 12.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.colorTextBlue,
                ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
/*
   Expanded(
            child: StreamBuilder(
              stream: _packages_details.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Column(
                        children: [
                          Html(data: documentSnapshot['details']),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AppointmentButton(
                              onPressed: () {
                                /*Get.to(
                                      () => BookHealthCarePackageScreen(
                                    uid: documentSnapshot.id,
                                    price: documentSnapshot['price'],
                                    healthCareId: docId,
                                  ),
                                );*/
                              },
                              value: 'Book Now',
                            ),
                          ),
                          SizedBox(height: 20,)

                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
 */
