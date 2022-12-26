import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/properties.dart';

import '../../widget/common_toolbar.dart';
import '../../widget/text_widget.dart';
import '../home_screens/doctors_menu_screens/doctors_menu.dart';
import '../home_screens/visa/visa_screening_center.dart';
class AppointmentType extends StatelessWidget {
  const AppointmentType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> name=['Doctor Booking','Visa Screening Booking'];
    List<String> image=[
      'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/book-gp-appointment-1641476111.jpg',
      'https://image.khaleejtimes.com/?uuid=21d4592d-650f-5d33-a033-a6d7c597c21b&function=cropresize&type=preview&source=false&q=75&crop_w=0.99999&crop_h=0.83799&width=1200&height=675&x=1.0E-5&y=0.16015']
    ;
    return Scaffold(
      appBar: CommonToolbar(title: 'Select Your appointment'),
      body: ListView.builder(
        itemCount: image.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              if(index==0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));

              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VisaScreeningCenterScreen()));

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140.h,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.network(
                      image[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.8), colorBlendMode: BlendMode.modulate,
                    ),

                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 40.h,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: TextWidget(
                              value: name[index],
                              size: 18.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white60,
                                    Properties.primaryColor,
                                  ])),
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        },

      ),

    );
  }
}
