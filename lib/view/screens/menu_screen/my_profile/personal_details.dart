import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:somerian_health/global/properties.dart';

import '../../../widget/text_widget.dart';
class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> with TickerProviderStateMixin {
  bool isVisible=false;
  String? imagePath;
  File? _image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemp = File(image!.path);
      setState(() {
        _image = imageTemp;
        saveImage(_image!.path);
      });
    } on PlatformException catch (e) {
      print('Failed: $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Row(
                       children: [
                         Center(
                           child: Stack(
                             children: [
                               imagePath != null
                                   ? CircleAvatar(
                                 backgroundImage: FileImage(File(imagePath!)),
                                 radius: 60,
                               )
                                   : CircleAvatar(
                                 radius: 60,
                                 backgroundImage: _image != null
                                     ? Image.file(_image!).image
                                     : NetworkImage('https://cutt.ly/yVi8MKf'),
                               ),
                               Positioned(
                                   bottom: 0,
                                   right: 4,
                                   child: InkWell(
                                       onTap: () {
                                         pickImage();
                                       },
                                       child: buildEditIcon())),
                             ],
                           ),
                         ),
                         TextWidget(
                           value: 'Mohammad Ali Jitendra',
                           textColor: Properties.colorTextBlue,
                           size: 18.sp,
                           fontWeight: FontWeight.w700,
                         ),
                       ],
                     ),
                     InkWell(
                         onTap: (){
                           setState(() {
                             isVisible=!isVisible
                             ;
                           });
                         },
                         child: Container(
                             width: 30.w,
                             height: 30.h,
                             decoration: BoxDecoration(
                               color: Properties.primaryColor,
                               shape: BoxShape.circle

                             ),
                             child: Icon(Icons.edit,size: 20,color: Colors.white,)))


                   ],
                 ),
               ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  TextWidget(
                    value: 'Date of Birth',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "15 October 1979",
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value){
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),
                  TextWidget(
                    value: 'Mobiile Number ',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "01776646603",
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value){

                    },
                    decoration: InputDecoration(

                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),
                  TextWidget(
                    value: 'Email',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "fhbrabby@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){

                    },
                    decoration: InputDecoration(

                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),
                  TextWidget(
                    value: 'Gender',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "Male",
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){

                    },
                    decoration: InputDecoration(

                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),

                  TextWidget(
                    value: 'Nationality',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "India",
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){

                    },
                    decoration: InputDecoration(

                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),
                  TextWidget(
                    value: 'Emirates ID',
                    textColor: Properties.colorTextBlue,
                    size: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 7.h,),
                  TextFormField(
                    enabled:isVisible? true:false,
                    initialValue: "1234-5678-9011",
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){

                    },
                    decoration: InputDecoration(

                      hintStyle: TextStyle(fontSize: 16.sp, color: Color.fromRGBO(0, 48, 73, 0.5)),
                      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                  SizedBox(height: 7.h,),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          height: 50,
                          minWidth: double.maxFinite,
                          color: Properties.primaryColor,

                          child: Text("Update profile",style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold

                          ),),
                          onPressed: ()
                          {
                            setState(() {
                              isVisible=false;
                            });

                          }

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void saveImage(String path) async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString("imagepath", path);
  }

  void loadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      imagePath = saveImage.getString("imagepath");
    });
  }
}
Widget buildEditIcon() {
  return ClipOval(
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(2),
      child: ClipOval(
        child: Container(
            padding: EdgeInsets.all(5),
            color: Properties.colorTextBlue,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 20,
              color: Colors.white,
            )),
      ),
    ),
  );
}
