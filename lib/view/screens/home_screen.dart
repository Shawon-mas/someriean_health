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

import '../../controller/carousel_controller.dart';
import '../../controller/controllers.dart';
import '../widget/carousel_loading.dart';
import '../widget/carousel_with_indicator.dart';
import '../widget/homeMenu.dart';
import '../widget/primary_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/text_widget.dart';
import 'menu_screens/doctors_menu_screens/doctors_menu.dart';

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
                  HomeMenu(menuTittle: "Doctors",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsMenuScreen()));

                  }),
                  Container(
                      height: 115.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Specialties",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
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
                  Container(
                      height: 115.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Insurance",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
                  Container(
                      height: 115.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Health Packages",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
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
                  Container(
                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          TextWidget(
                            value: "Find Hospitals & Clinics",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      )),
                  Container(
                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Book Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
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
                  Container(
                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Manage Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
                  Container(
                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/splash.png',
                                height: 80,
                                width: 100,
                              ),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Vaccination Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )),
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
