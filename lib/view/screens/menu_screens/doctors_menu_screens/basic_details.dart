import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../../controller/complete_profile_controller.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
import '../../otp_screen.dart';
class BasicDetailsScreen extends StatefulWidget {

   BasicDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  final _controller = Get.put(CompleteProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonToolbar(title: 'Doctors'),
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          // controller: _controller.firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Properties.primaryColor, width: 1.0),
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
                          //   controller: _controller.lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Properties.primaryColor, width: 1.0),
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
                  TextFormField(
                    //   controller: _controller.mobileController,
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
                    // controller: _controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email Id',
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
                    //   controller: _controller.mobileController,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Time and date',
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
                    //   controller: _controller.mobileController,
                    enabled: false,

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_file_outlined),
                      hintText: 'Attachment (previous medical report if available)',
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
                    //   controller: _controller.mobileController,
                    enabled: true,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10,50,0,50),
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
                    height:20,
                  ),
                  AppointmentButton(
                    onPressed: (){
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
                    },
                    value:'Next' ,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
