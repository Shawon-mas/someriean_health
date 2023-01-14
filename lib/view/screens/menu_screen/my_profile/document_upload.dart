import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../controller/documentUpload_controller.dart';
import '../../../../global/properties.dart';
import '../../../../utilites/api_services.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../../../widget/webview.dart';

class DocumentUpload extends StatelessWidget {
  final controller = Get.put(DocumentController());
  DocumentUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    Obx(
                      () => controller.emiratesFront.value == ''
                          ? AppointmentButton(
                              onPressed: () {
                                controller.pickEfImage();
                              },
                              value: 'Upload Front Copy',
                            )
                          : InkWell(
                              onTap: () async {
                                Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.emiratesFront.value));
                               /* if (await canLaunchUrl(Uri.parse(
                                    ApiServices.IMAGE_BASE_URL + controller.emiratesFront.value))) {
                                  launchUrl(
                                    Uri.parse(ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesFront.value),
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                  );*/

                              },
                              child: Text(
                                controller.emiratesFront.value
                                    .replaceAll('assets/', ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                     SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => controller.emiratesBack.value == ''
                          ? AppointmentButton(
                              onPressed: () {
                                controller.pickEbImage();
                              },
                              value: 'Upload Back Copy',
                            )
                          : InkWell(
                              onTap: () async {
                                Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.emiratesBack.value));
                                /*   if (await canLaunchUrl(Uri.parse(
                                    ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesBack.value))) {
                                  launchUrl(
                                    Uri.parse(ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesBack.value),
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                  );
                                }*/
                              },
                              child: Text(
                                controller.emiratesBack.value
                                    .replaceAll('assets/', ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                  ],
                ))
              ],
            ),
            Divider(
              color: Colors.black12,
            ),
            Row(
              children: [
                Expanded(
                    child: TextWidget(
                  value: 'Passport',
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Properties.colorTextBlue,
                )),
                Expanded(
                  child: Obx(
                    () => controller.passport.value == ''
                        ? AppointmentButton(
                            onPressed: () {
                              controller.pickPassportImage();
                            },
                            value: 'Upload',
                          )
                        : InkWell(
                            onTap: () async {
                              Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.passport.value));

                              /*  if (await canLaunchUrl(Uri.parse(
                                  ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value))) {
                                launchUrl(
                                  Uri.parse(ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              }*/
                            },
                            child: Text(
                              controller.passport.value
                                  .replaceAll('assets/', ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black12,
            ),
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
                  child: Obx(
                    () => controller.visa.value == ''
                        ? AppointmentButton(
                            onPressed: () {
                              controller.pickVisaImage();
                            },
                            value: 'Upload',
                          )
                        : InkWell(
                            onTap: () async {
                              Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.visa.value));

                              /*  if (await canLaunchUrl(Uri.parse(
                                  ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value))) {
                                launchUrl(
                                  Uri.parse(ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              }*/
                            },
                            child: Text(
                              controller.visa .value
                                  .replaceAll('assets/', ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black12,
            ),
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
                  child: Obx(
                    () => controller.insurance.value == ''
                        ? AppointmentButton(
                            onPressed: () {
                              controller.pickInsuranceImage();
                            },
                            value: 'Upload',
                          )
                        : InkWell(
                            onTap: () async {
                              Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.insurance.value));

                              /*if (await canLaunchUrl(Uri.parse(
                                  ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value))) {
                                launchUrl(
                                  Uri.parse(ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              }*/
                            },
                            child: Text(
                              controller.insurance.value
                                  .replaceAll('assets/', ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black12,
            ),
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
                  child: Obx(
                    () => controller.others.value == ''
                        ? AppointmentButton(
                            onPressed: () {
                              controller.pickOthersImage();
                            },
                            value: 'Upload',
                          )
                        : InkWell(
                            onTap: () async {
                              Get.to(()=> WebViewScreen(url: ApiServices.IMAGE_BASE_URL + controller.others.value));

                              /*   if (await canLaunchUrl(Uri.parse(
                                  ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value))) {
                                launchUrl(
                                  Uri.parse(ApiServices.IMAGE_BASE_URL +
                                      controller.emiratesFront.value),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              }*/
                            },
                            child: Text(
                              controller.others.value
                                  .replaceAll('assets/', ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
