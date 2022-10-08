import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/controller/complete_profile_controller.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/widget/custom_button.dart';
import '../widget/custom_container.dart';
import '../widget/text_widget.dart';

class CompleteProfileScreen extends StatelessWidget {
  final _controller = Get.put(CompleteProfileController());
  final String mobileNumber;
  final String uid;
  CompleteProfileScreen(
      {Key? key, required this.mobileNumber, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.mobileController.text = mobileNumber;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CommonToolbar(
        title: 'Complete your profile',
      ),
      body: Column(
        children: [
          CustomContainer(value: "Please provide basic details"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller.firstNameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _controller.lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _controller.selectDate(context);
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
                TextFormField(
                  controller: _controller.mobileController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Mobile No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _controller.emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                        _controller.valueNationality.value = newValue as String;
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
                TextFormField(
                  controller: _controller.passportController,
                  decoration: InputDecoration(
                    hintText: 'Emirates ID/Passport No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 55.h,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              value: "Submit",
              onPressed: () {
                _controller.storeValues(
                  firstName: _controller.firstNameController.text,
                  lastName: _controller.lastNameController.text,
                  dob: _controller.selectedDate.value,
                  mobileNo: mobileNumber,
                  email: _controller.emailController.text,
                  gender: _controller.valueChoose.value,
                  nationality: _controller.valueNationality.value,
                  passport: _controller.passportController.text,
                  uid: uid,
                  context: context,
                );
              },
              isLoading: _controller.isUploading.value,
            ),
          ),
        ),
      ),
    );
  }
}

