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
                                if (await canLaunchUrl(Uri.parse(
                                    ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesFront.value))) {
                                  launchUrl(
                                    Uri.parse(ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesFront.value),
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                  );
                                }
                              },
                              child: Text(
                                controller.emiratesFront.value
                                    .replaceAll('assets/', ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                    SizedBox(height: 10.h,),
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
                                if (await canLaunchUrl(Uri.parse(
                                    ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesBack.value))) {
                                  launchUrl(
                                    Uri.parse(ApiServices.IMAGE_BASE_URL +
                                        controller.emiratesBack.value),
                                    mode: LaunchMode
                                        .externalNonBrowserApplication,
                                  );
                                }
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
            )
          ],
        ),
      ),
    );
  }
}
