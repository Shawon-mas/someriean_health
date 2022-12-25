import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:somerian_health/global/properties.dart';

import '../../../global/db_paths.dart';
import '../../../global/global_constants.dart';
import '../../../model/slider_model.dart';
import '../../../routes/routes.dart';
import '../../widget/homeMenu.dart';
import '../../widget/primary_toolbar.dart';
import '../../widget/text_widget.dart';
import '../home_screens/ambulance/ambulance_list.dart';
import '../home_screens/contact_us/contact_us.dart';
import '../home_screens/covid19/screening_center.dart';
import '../home_screens/doctors_menu_screens/doctors_menu.dart';
import '../home_screens/e-pharmacy/epharmacy_item.dart';
import '../home_screens/emergency/emergency_contact.dart';
import '../home_screens/find_us/location.dart';
import '../home_screens/find_us/location_one.dart';
import '../home_screens/health_packages/packages_list.dart';
import '../home_screens/health_tip/health_tip.dart';
import '../home_screens/home_care/home_care_facility.dart';
import '../home_screens/home_care/home_care_location.dart';
import '../home_screens/insurance/insurance.dart';
import '../home_screens/insurance/insurance_list.dart';
import '../home_screens/manage_appiontment/manage_appionment.dart';
import '../home_screens/medical_history/medical_history.dart';
import '../home_screens/reports/reports_type.dart';
import '../home_screens/specialties_menu/choose_specialty.dart';
import '../home_screens/teleconsultation/teleconsultation.dart';
import '../home_screens/vaccination/vaccination.dart';
import '../home_screens/visa/visa_screening_center.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 56.h,
                width: double.infinity,
                color: Properties.primaryColor,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        'assets/images/splash.png',
                        /*   height: 70.h,
            width: 50.w,*/
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(DbCollections.collectionImages)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List<String> images = [];
                      List<SliderModel> sliders = [];
                      if (snapshot.hasData) {
                        for (var data in snapshot.data!.docs) {
                          images.add(data['imageUrl']);
                          sliders.add(SliderModel(
                              imageUrl: data['imageUrl'],
                              url: data['url'],
                              title: data['title']));
                        }
                      }
                      return snapshot.hasData
                          ? Column(
                            children: [
                              CarouselSlider(
                        options: CarouselOptions(
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              aspectRatio: 16/9,
                              viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }

                        ),
                               items: sliders
                                .map(
                                  (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        infoSnackBar(context,
                                            "Onclick event: ${e.title}");
                                      },
                                      child: SizedBox(
                                        height: 100.h,
                                        child: Image.network(
                                          e.imageUrl,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        )
                                .toList(),
                      ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: sliders.map((url) {
                                  int index = sliders.indexOf(url);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index
                                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                                          : const Color.fromRGBO(0, 0, 0, 0.4),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                          : const Center(
                               child: CircularProgressIndicator(),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextWidget(
                    textColor: Properties.colorTextBlue,
                    value: "Our Services",
                    textAlign: TextAlign.center,
                    size: 20.sp,
                    fontWeight: FontWeight.w700,
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Doctors",
                        imageMenu: 'assets/images/doctor.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));

                        }),
                    HomeMenu(
                        menuTittle: "Specialties",
                        imageMenu: 'assets/images/stethoscope.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseSpecialty()));
                          // infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Insurance",
                        imageMenu: 'assets/images/insurance.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>InsuranceList()));
                        //   infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Health Packages",
                        imageMenu: 'assets/images/health_packages.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PackagesListScreen()));
                          //  infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Find us",
                        imageMenu: 'assets/images/clinic.png',
                        onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationOneScreen(title: 'Find us',)));
                        //  infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Book Appointment",
                        imageMenu: 'assets/images/booking_appointment.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationOneScreen(title: 'Book Appointment',)));
                        //  infoSnackBar(context,'Coming soon');
                        }),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Manage Appointment",
                        imageMenu: 'assets/images/manage_appointment.png',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageAppiontment()));
                         // infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Ambulance Services",
                        imageMenu: 'assets/images/ambulance.png',
                        onPressed: (){

                          //    Navigator.push(context, MaterialPageRoute(builder: (context)=>VaccinationScreen()));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Ambulance_List()));
                        //  infoSnackBar(context,'Coming soon');

                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Emergency Contact",
                        imageMenu: 'assets/images/alarm.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyContact()));
                         // infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "E-pharmacy",
                        imageMenu: 'assets/images/pharmacy.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>EpharmacyList()));
                        //  infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Home Care",
                        imageMenu: 'assets/images/care.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeCareFacility()));
                        //  infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Teleconsultation",
                        imageMenu: 'assets/images/medical.png',
                        onPressed: (){
                         //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Teleconsultation()));
                         infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Medical History",
                        imageMenu: 'assets/images/medical_history.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicalHistory()));
                         // infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Reports",
                        imageMenu: 'assets/images/reports.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportsType()));
                         // infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeMenu(
                        menuTittle: "Health Tip",
                        imageMenu: 'assets/images/health_tip.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>HealthTip()));
                          //infoSnackBar(context,'Coming soon');
                        }),
                    HomeMenu(
                        menuTittle: "Contact Us",
                        imageMenu: 'assets/images/contact.png',
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs(title: 'Contact Us',)));
                         // infoSnackBar(context,'Coming soon');
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
