import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/controller/complete_profile_controller.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/custom_button.dart';
import '../../global/properties.dart';
import '../widget/custom_container.dart';
import '../widget/text_widget.dart';

class CompleteProfileScreen extends StatelessWidget {
  final _controller = Get.put(CompleteProfileController());
  final String mobileNumber;

  CompleteProfileScreen({Key? key, required this.mobileNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.mobileController.text = mobileNumber;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CommonToolbar(
        title: 'Complete your profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(value: "Please provide basic details"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //_controller.firstNameController _controller.lastNameController
                      Expanded(
                        child: customTextField(
                            enabled: true,
                            textEditingController:
                                _controller.firstNameController,
                            helperText: "Full Name"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(
                            enabled: true,
                            textEditingController:
                                _controller.firstNameController,
                            helperText: "Last Name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    value: 'Select Preferred Time',
                    size: 14.sp,
                    fontWeight: FontWeight.w300,
                    textColor: Colors.grey,
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _controller.selectDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 50.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                            () => TextWidget(
                              value:
                                  '${_controller.selectedDate.value.day}/${_controller.selectedDate.value.month}/${_controller.selectedDate.value.year}',
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
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      enabled: false,
                      textEditingController: _controller.mobileController,
                      helperText: "Mobile Number"),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      enabled: true,
                      textEditingController: _controller.emailController,
                      helperText: "Email"),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Obx(
                      () => DropdownButton(
                        hint: const Text('Gender'),
                        isExpanded: true,
                        value: _controller.valueChoose.value == ""
                            ? null
                            : _controller.valueChoose.value,
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          _controller.valueChoose.value = newValue as String;
                        },
                        items: _controller.gender.map((valuItem) {
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Obx(
                      () => DropdownButton(
                        hint: const Text('Nationality'),
                        isExpanded: true,
                        value: _controller.valueNationality.value == ""
                            ? null
                            : _controller.valueNationality.value,
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          _controller.valueNationality.value =
                              newValue as String;
                        },
                        items: _controller.nationality.map((valuItem) {
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
                  customTextField(
                      enabled: true,
                      textEditingController: _controller.passportController,
                      helperText: "Emirates ID"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.h,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              value: "Submit",
              onPressed: () {
                /* _controller.storeValues(
                  firstName: _controller.firstNameController.text,
                  lastName: _controller.lastNameController.text,
                  dob: _controller.selectedDate.value,
                  mobileNo: mobileNumber,
                  email: _controller.emailController.text,
                  gender: _controller.valueChoose.value,
                  nationality: _controller.valueNationality.value,
                  passport: _controller.passportController.text,
                  context: context,
                );*/
                _controller.checkFieldCheck(context);
              },
              isLoading: _controller.isUploading.value,
            ),
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
        TextFormField(
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
