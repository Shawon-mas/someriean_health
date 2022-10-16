import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../global/db_paths.dart';
import '../../../global/global_constants.dart';
import '../../../model/slider_model.dart';
import '../../../routes/routes.dart';
import '../../widget/homeMenu.dart';
import '../../widget/primary_toolbar.dart';
import '../home_screens/doctors_menu_screens/doctors_menu.dart';
import '../home_screens/health_packages/packages_list.dart';
import '../home_screens/insurance/insurance.dart';
import '../home_screens/specialties_menu/choose_specialty.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryToolbar(
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Insurance()));
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Book Appointment",
                      imageMenu: 'assets/images/booking_appointment.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
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
                      menuTittle: "Manage Appointment",
                      imageMenu: 'assets/images/manage_appointment.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Vaccination Appointment",
                      imageMenu: 'assets/images/vaccination_appointment.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
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
                      menuTittle: "Covid-19 Screening Appointment",
                      imageMenu: 'assets/images/covid_19.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Visa Screening Appointment",
                      imageMenu: 'assets/images/visa.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
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
                      menuTittle: "Home Care",
                      imageMenu: 'assets/images/care.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Teleconsultation",
                      imageMenu: 'assets/images/teleconsultation.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Reports",
                      imageMenu: 'assets/images/reports.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
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
                      menuTittle: "Health Tip",
                      imageMenu: 'assets/images/health_tip.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
                      }),
                  HomeMenu(
                      menuTittle: "Contact Us",
                      imageMenu: 'assets/images/contact.png',
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));
                        infoSnackBar(context,'Coming soon');
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
    );
  }
}
