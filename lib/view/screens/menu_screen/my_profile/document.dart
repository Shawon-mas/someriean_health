import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/doctor_appointment_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
   PlatformFile? platformFile;
   Future selectFile() async{
     final result=await FilePicker.platform.pickFiles();
     if(result==null) return ;
     setState(() {
       platformFile=result.files.first;
     });
   }
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(DoctorAppointmentController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
              Expanded(child: Column(
                children: [

                 platformFile==null?
                 AppointmentButton(
                    onPressed: (){
                      selectFile();
                    },
                    value: 'Upload Front Copy',
                  )
                  :Text(platformFile!.name),
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload Back Copy',
                  ),
                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Passport',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Visa',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Insurance',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(child: TextWidget(
                value: 'Others',
                size: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: Properties.colorTextBlue,
              )),
              Expanded(child: Column(
                children: [
                  AppointmentButton(
                    onPressed: (){

                    },
                    value: 'Upload',
                  ),

                ],
              ))
            ],
          ),

        ],
      ),
    );
  }
}
/*
  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      dense: false,
                      contentPadding: EdgeInsets.zero,
                      leading: IconButton(
                        icon: Icon(Icons.attach_file_outlined),
                        onPressed: () {
                          _controller.filePicker();
                        },
                      ),
                      title: Obx(
                            () => Text((_controller.selectedFile.value),
                        ),
                      ),
                    ),
                  ),
 */
