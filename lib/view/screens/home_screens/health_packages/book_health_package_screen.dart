import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/healthcare_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class BookHealthCarePackageScreen extends StatelessWidget {
  final String uid;
  final String price;
  final String healthCareId;

  BookHealthCarePackageScreen({Key? key, required this.uid, required this.price, required this.healthCareId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthcareController(context: context, uid: uid, price: price, healthcareId: healthCareId));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonToolbar(title: 'Book Healthcare Package'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: customTextField(textEditingController: controller.firstNameController, helperText: "First Name"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(textEditingController: controller.lastNameController, helperText: "Last Name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(textEditingController: controller.mobileController, helperText: "Mobile No"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(textEditingController: controller.emailController, helperText: "Email Id"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(textEditingController: controller.genderController, helperText: "Gender"),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(textEditingController: controller.nationalityController, helperText: "Nationality"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: customTextField(
                          textEditingController: controller.timeController,
                          helperText: "Time",
                          enabled: true,
                          trailingIcon: IconButton(
                            onPressed: () {
                              controller.selectTime(context);
                            },
                            icon: Icon(
                              Icons.schedule,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: customTextField(
                          textEditingController: controller.dateController,
                          helperText: "Date",
                          enabled: true,
                          trailingIcon: IconButton(
                            onPressed: () {
                              controller.selectDate(context);
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StreamBuilder(
                    stream: controller.doctors.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        for (var data in snapshot.data!.docs) {
                          controller.locations.value.add(data['location']);
                        }
                        controller.selectedLocation.value = controller.locations.first;
                        controller.locations.value = controller.locations.toSet().toList();
                      }
                      return snapshot.hasData
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 30,
                                    horizontal: 4,
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              //color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Obx(
                                              () => DropdownButton(
                                                hint: Text('Location'),
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: controller.selectedLocation.value == "" ? null : controller.selectedLocation.value,
                                                icon: const Icon(Icons.keyboard_arrow_down),
                                                items: controller.locations.map((items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  controller.selectedLocation.value = newValue as String;
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Location',
                                              style: TextStyle(
                                                color: Colors.grey,
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
                ],
              ),
            ),
            ListTile(
              //leading: Text("AED"),
              subtitle: Text("Price"),
              title: Container(
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
                  "AED " + price,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: controller.messageController,
                enabled: true,
                decoration: InputDecoration(
                  helperText: 'Message',
                  hintText: "Message (Optional)",
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 50, 0, 50),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() => AppointmentButton(
                    isLoading: controller.isProcessing.value,
                    onPressed: () {
                      controller.proceedPayment(context, controller);
                    },
                    value: 'Proceed',
                  )),
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppointmentButton(
          onPressed: () {
            controller.proceedDialog(context, controller);
          },
          value: 'Proceed',
        ),
      ),*/
    );
  }

  Widget customTextField({required TextEditingController textEditingController, required String helperText, bool? enabled = false, Widget? trailingIcon}) {
    return TextField(
      enabled: enabled,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: trailingIcon,
        helperText: helperText,
        helperStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Properties.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
