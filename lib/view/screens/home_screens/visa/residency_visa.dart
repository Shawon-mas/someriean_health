import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/visa_appointment_controller.dart';
import '../../../../global/global_constants.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class ResidencyVisa extends StatelessWidget {
  final controller = Get.put(VisaScreeningController());
  final String title;
  ResidencyVisa({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: customTextField(
                        textEditingController: controller.firstNameController,
                        helperText: "First Name"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: customTextField(
                        textEditingController: controller.lastNameController,
                        helperText: "Last Name"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  textEditingController: controller.mobileController,
                  helperText: "Mobile No"),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  textEditingController: controller.emailController,
                  helperText: "Email Id"),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  textEditingController: controller.genderController,
                  helperText: "Gender"),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  textEditingController: controller.emiratesController,
                  helperText: "Emirates Id"),
              const SizedBox(
                height: 10,
              ),
              customTextField(
                  textEditingController: controller.nationalityController,
                  helperText: "Date of birth"),
              const SizedBox(
                height: 10,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        height: 40.h,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Obx(
                              () => TextWidget(
                                value:
                                    '${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}',
                                size: 14.sp,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.selectTime(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        height: 40.h,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Obx(
                              () => TextWidget(
                                value: controller.selectedTime.value
                                    .format(context)
                                    .toString(),
                                size: 14.sp,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Image.asset('assets/images/clock.png')
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(()=> InkWell(
                onTap: () {
                     controller.getEmirates(context);
                },
                child: Container(
                  width: double.maxFinite,
                  height: 40.h,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      TextWidget(
                        value: controller.visaEmiratesName.value == ''
                            ? 'Pick Your Emirate'
                            : controller.visaEmiratesName.value,
                        size: 14.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.black,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_drop_down_outlined)
                    ],
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
             Obx(() =>InkWell(
               onTap: () {
                    controller.getPackages(context);
               },
               child: Container(
                 width: double.maxFinite,
                 height: 40.h,
                 padding: const EdgeInsets.symmetric(horizontal: 10),
                 decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey),
                     borderRadius: BorderRadius.circular(10.0)),
                 child: Row(
                   children: [
                     TextWidget(
                       value: controller.visaPackageName.value == ''
                           ? 'Pick Your Packages'
                           : controller.visaPackageName.value,
                       size: 14.sp,
                       fontWeight: FontWeight.w700,
                       textColor: Colors.black,
                     ),
                     Spacer(),
                     Icon(Icons.arrow_drop_down_outlined)
                   ],
                 ),
               ),
             ) ) ,
              const SizedBox(
                height: 10,
              ),
              customTextField(
                enabled: true,
                  textEditingController: controller.messageController,
                  helperText: "Address"),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50.h,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Obx(
                  () => DropdownButton(
                    hint: const Text('Select Visa Types'),
                    isExpanded: true,
                    value: controller.selectVisaTypes.value == ""
                        ? null
                        : controller.selectVisaTypes.value,
                    underline: const SizedBox(),
                    onChanged: (newValue) {
                      controller.selectVisaTypes.value = newValue as String;
                    },
                    items: controller.visaTypes.map((valuItem) {
                      return DropdownMenuItem(
                        value: valuItem,
                        child: Text(valuItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50.h,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Obx(
                  () => DropdownButton(
                    hint: const Text('Select Payment Methods'),
                    isExpanded: true,
                    value: controller.selectPayment.value == ""
                        ? null
                        : controller.selectPayment.value,
                    underline: const SizedBox(),
                    onChanged: (newValue) {
                      controller.selectPayment.value = newValue as String;
                    },
                    items: controller.paymentMethods.map((valuItem) {
                      return DropdownMenuItem(
                        value: valuItem,
                        child: Text(valuItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => AppointmentButton(
                isLoading: controller.isProcessing.value,
                onPressed: () {
                  if (controller.visaEmiratesName.value == '') {
                    errorSnackBar(context, 'Emirates Name Required');
                  }else if (controller.visaPackageName.value == '') {
                    errorSnackBar(context, 'Package Name Required');
                  }else if (controller.messageController.text.isEmpty) {
                    errorSnackBar(context, 'Address Required');
                  }else if (controller.selectVisaTypes.value == '') {
                    errorSnackBar(context, 'Visa Type Required');
                  }else if (controller.selectPayment.value == '') {
                    errorSnackBar(context, 'Payment Methods required');
                  }else{
                    controller.bookResidencyVisa(context);

                  }
                },
                value: 'Proceed',
              )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget customTextField(
      {required TextEditingController textEditingController,
      required String helperText,
      TextInputType? textInputType,
      EdgeInsets? edgeInsets,
      bool? enabled = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helperText,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: textInputType,
          enabled: enabled,
          controller: textEditingController,
          decoration: InputDecoration(
            /* helperText: helperText,
            helperStyle: TextStyle(
              color: Colors.grey,
            ),*/
            contentPadding: edgeInsets,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Properties.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
