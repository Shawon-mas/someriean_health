import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/healthcare_controller.dart';
import '../../../../global/global_constants.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class BookHealthCarePackageScreen extends StatelessWidget {
  final HealthcareController controller;
  BookHealthCarePackageScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CommonToolbar(title: 'Book Healthcare Package'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: 50.h,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextWidget(
                  value: "Please provide basic detalis",
                  size: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: customTextField(
                            textEditingController:
                                controller.firstNameController,
                            helperText: "First Name"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(
                            textEditingController:
                                controller.lastNameController,
                            helperText: "Last Name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.mobileController,
                      helperText: "Mobile No"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.emailController,
                      helperText: "Email Id"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.genderController,
                      helperText: "Gender"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      textEditingController: controller.nationalityController,
                      helperText: "Nationality"),
                  const SizedBox(
                    height: 20,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          ),
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                 Obx(() => InkWell(
                   onTap: () {
                     controller.getLocationList(context);
                   },
                   child: Container(
                     height: 40.h,
                     width: double.maxFinite,
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.grey),
                         borderRadius: BorderRadius.circular(10.0)),
                     child: Row(
                       children: [
                         TextWidget(
                           value: controller.selectedLocationName.value==''
                               ? 'Pick Hospital Location'
                               :controller.selectedLocationName.value,
                           size: 14.sp,
                           fontWeight: FontWeight.w700,
                           textColor: Colors.black54,
                         ),
                         Spacer(),
                         Icon(Icons.location_city_outlined,color: Colors.black54,)
                       ],
                     ),
                   ),
                 ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Price',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              //leading: Text("AED"),
              title: Container(
                height: 50.h,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  "AED " + controller.selectedPackage.price,
                ),
              ),
            ),
            /*+
            Text(
                  "AED " + price,
                )
                controller.c_employeesController.text.toString()==null
             */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Obx(
                  () => DropdownButton(
                    hint: const Text('For Whom'),
                    isExpanded: true,
                    value: controller.valueAppointment.value == ""
                        ? null
                        : controller.valueAppointment.value,
                    underline: const SizedBox(),
                    onChanged: (newValue) {
                      controller.valueAppointment.value = newValue as String;
                      if(newValue=='Book for Self'){
                        controller.bookForWhom.value='Book for Self';
                      }else{
                        controller.bookForWhom.value='Book for Company';
                      }
                    },
                    items: controller.appointmentType.map((valuItem) {
                      return DropdownMenuItem(
                        value: valuItem,
                        child: Text(valuItem),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Obx(
                  () => DropdownButton(
                    hint: const Text('Select Payment Method'),
                    isExpanded: true,
                    value: controller.valuePayment.value == ""
                        ? null
                        : controller.valuePayment.value,
                    underline: const SizedBox(),
                    onChanged: (newValue) {
                      controller.valuePayment.value = newValue as String;
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => Visibility(
                    visible:
                        controller.valueAppointment.value == 'Book for Company',
                    child: Column(
                      children: [
                        customTextField(
                            enabled: true,
                            textEditingController: controller.c_nameController,
                            helperText: "Company Name"),
                        SizedBox(
                          height: 5.h,
                        ),
                        customTextField(
                            enabled: true,
                            textEditingController:
                                controller.c_numberController,
                            helperText: "Company Phone Number"),
                        SizedBox(
                          height: 5.h,
                        ),
                        customTextField(
                            enabled: true,
                            textEditingController: controller.c_emailController,
                            helperText: "Company Email"),
                        SizedBox(
                          height: 5.h,
                        ),
                        customTextField(
                            enabled: true,
                            textEditingController:
                                controller.c_personController,
                            helperText: "Name of Authorized Person"),
                        SizedBox(
                          height: 5.h,
                        ),
                        customTextField(
                            enabled: true,
                            textEditingController:
                                controller.c_addressController,
                            helperText: "Company Address"),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: customTextField(
                  enabled: true,
                  textEditingController: controller.messageController,
                  helperText: "Message (Optional)",
                  edgeInsets: EdgeInsets.fromLTRB(10, 50, 0, 50)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() => AppointmentButton(
                    isLoading: controller.isProcessing.value,
                    onPressed: () {
                      // controller.proceedPayment(context, controller);
                      if(controller.selectedLocationName.value==''){
                        errorSnackBar(context, 'Hospital Location Required');
                      } else if(controller.valueAppointment.value == ''){
                        errorSnackBar(context, 'For Whom Required');
                      }else if(controller.valuePayment.value==''){
                        errorSnackBar(context, 'Payment Method Required');
                      } else if(controller.valueAppointment.value == 'Book for Company'){
                         if(controller.c_nameController.text.isEmpty){
                           errorSnackBar(context, 'Company Name Required');
                         }else if(controller.c_nameController.text.isEmpty){
                           errorSnackBar(context, 'Company Name Required');
                         }else if(controller.c_nameController.text.isEmpty){
                           errorSnackBar(context, 'Company Number Required');
                         }else if(controller.c_emailController.text.isEmpty){
                           errorSnackBar(context, 'Company Email Required');
                         }else if(controller.c_personController.text.isEmpty){
                           errorSnackBar(context, 'Company Authorized Person Name Required');
                         }else if(controller.c_addressController.text.isEmpty){
                           errorSnackBar(context, 'Company Address Required');
                         }else{
                           controller.bookedHealthPackage(context);
                         }

                      } else{
                        controller.bookedHealthPackage(context);
                        print(true);
                      }

                    },
                    value: 'Proceed',
                  )),
            ),
          ],
        ),
      ),

    );
  }

  Widget customTextField(
      {required TextEditingController textEditingController,
      required String helperText,
      bool? enabled = false,
      EdgeInsets? edgeInsets,
      Widget? trailingIcon}) {
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
                  const BorderSide(color: Properties.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
/*
   StreamBuilder(
                    stream: controller.doctors.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        for (var data in snapshot.data!.docs) {
                          controller.locations.value.add(data['location']);
                        }
                        controller.selectedLocation.value =
                            controller.locations.first;
                        controller.locations.value =
                            controller.locations.toSet().toList();
                      }
                      return snapshot.hasData
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 4,
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Location',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              //color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Obx(
                                              () => DropdownButton(
                                                hint: Text('Location'),
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: controller
                                                            .selectedLocation
                                                            .value ==
                                                        ""
                                                    ? null
                                                    : controller
                                                        .selectedLocation.value,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: controller.locations
                                                    .map((items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  controller.selectedLocation
                                                          .value =
                                                      newValue as String;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
 */
