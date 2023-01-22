import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/home_screens/health_packages/package_details.dart';
import '../../../../controller/healthcare_controller.dart';
import '../../../../model/healthPackageListResponseModel.dart';
import '../../../../model/selected_health_package.dart';
import '../../../../utilites/api_services.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';

class PackagesListScreen extends StatelessWidget {
  final controller=Get.put(HealthcareController());
   PackagesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Health Packages'),
      body:Obx(()=> controller.isDataFetch.value==true?
          ListView.builder(
          itemCount: controller.healthPackageList.length,
          itemBuilder: (context, index) {
            List<HealthPackageDatum?>? getPackageList=controller.healthPackageList;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 110.h,
                    child: Stack(
                      children: [
                        Image.network(
                          ApiServices.IMAGE_BASE_URL + getPackageList[index]!.healthPackageImage!,
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: TextWidget(
                                  value: getPackageList[index]!.healthPackageName!,
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
                                      ])),
                            )
                        )
                      ],
                    ),
                  ),
                  Obx(()=>InkWell(
                    onTap: () {
                      controller.selectedPackage=SelectedHealthPackageModel(
                        price: getPackageList[index]!.healthPackagePrice!,
                        id: getPackageList[index]!.healthPackagePrice!.toString(),
                        title: getPackageList[index]!.healthPackageTitle!,
                        image: ApiServices.IMAGE_BASE_URL + getPackageList[index]!.healthPackageImage!,
                        name: getPackageList[index]!.healthPackageName!,
                        details: getPackageList[index]!.healthPackageDetails!
                      );
                      Get.to(()=> PackageDetails(
                       controller: controller,

                      ));

                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PackageDetails(
                                image: documentSnapshot['image'],
                                title: documentSnapshot['name'],
                                docId: documentSnapshot.id,
                              )));*/
                    },
                    child: Row(
                      children: [
                        TextWidget(
                          value: 'AED ${getPackageList[index]!.healthPackagePrice!} onward',
                          size: 18.sp,
                          fontWeight: FontWeight.w700,
                          textColor: Properties.fontColor,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              value: 'Know more',
                              size: 14.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Properties.primaryColor,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15.sp,
                              color: Properties.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            );
          })
          :Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}
