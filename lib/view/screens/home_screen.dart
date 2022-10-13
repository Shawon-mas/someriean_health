import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/model/slider_model.dart';
import 'package:somerian_health/routes/routes.dart';

import '../widget/homeMenu.dart';
import '../widget/primary_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/text_widget.dart';
import 'menu_screens/doctors_menu_screens/doctors_menu.dart';
import 'menu_screens/health_packages/packages_list.dart';
import 'menu_screens/insurance/insurance.dart';
import 'menu_screens/specialties_menu/choose_specialty.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _controller = Get.put(CarouselController());
  final List<String> imageList = [
    'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
    'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
    'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
  ];

  final List<String> menuList = [
    'Doctors',
    'Specialties',
    'Insurance',
    'Health Packages',
    'Find Hospitals & Clinics',
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryToolbar(
        appbarIcons: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed(splash);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                        ? CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              autoPlay: true,
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
                       // infoSnackBar(context,'Coming soon');
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
                      menuTittle: "Find Hospitals & Clinics",
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



      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Report',
              backgroundColor: Properties.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
              backgroundColor: Properties.primaryColor),
        ],
        //type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        backgroundColor: Properties.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}


/*
Obx(
                () {
              if (_controller.isLoading.value) {
                return const Center(
                  child: CarouselLoading(),
                );
              } else {
                if (_controller.carouselItemList.isNotEmpty) {
                  return CarouselWithIndicator(
                      data: _controller.carouselItemList);
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.hourglass_empty),
                        Text("Data not found!")
                      ],
                    ),
                  );
                }
              }
            },
          )
 */
