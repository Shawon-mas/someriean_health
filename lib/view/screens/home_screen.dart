import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/properties.dart';

import '../../controller/carousel_controller.dart';
import '../../controller/controllers.dart';
import '../widget/carousel_loading.dart';
import '../widget/carousel_with_indicator.dart';
import '../widget/primary_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/text_widget.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _controller = Get.put(CarouselController());
 final List<String> imageList=[
   'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
   'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
   'https://content.gallup.com/origin/gallupinc/GallupSpaces/Production/Cms/WORKPLACEV9CMS/2bgqjhmw_0iifqf_p8twtq.jpg',
 ];

 final List<String> menuList=[
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
      appBar: PrimaryToolbar(),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlay: true,

                    ),
                    items: imageList.map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            height: 100.h,
                              child: Image.network(e,height: 100.h,fit: BoxFit.cover,))
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 10,),
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
                            border: Border.all(color: Properties.primaryColor)
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 80.h,
                              width: 100.h,
                              color: Properties.primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                              ),
                            ),
                            Spacer(),
                            TextWidget(
                              value: "Doctors",
                              size: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        )
                      ),
                      Container(

                        height: 115.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Properties.primaryColor)
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 80.h,
                              width: 100.h,
                              color: Properties.primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                              ),
                            ),
                            Spacer(),
                            TextWidget(
                              value: "Specialties",
                              size: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        )
                      ),

                    ],
                  ),
                ),
               SizedBox(height: 10,),
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
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Insurance",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                  ),
                  Container(

                      height: 115.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Health Packages",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                  ),

                ],
              ),
            ),
              SizedBox(height: 10,),
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
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                            ),
                          ),
                          TextWidget(
                            value: "Find Hospitals & Clinics",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 5,)
                        ],
                      )
                  ),
                  Container(

                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                            ),
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Book Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),

                        ],
                      )
                  ),

                ],
              ),
            ),
              SizedBox(height: 10,),
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
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/splash.png',height: 80,width: 100,),
                            ),
                          ),
                          TextWidget(
                            value: "Manage Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                  ),
                  Container(

                      height: 125.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Properties.primaryColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 70.h,
                            width: 100.h,
                            color: Properties.primaryColor,
                          ),
                          Spacer(),
                          TextWidget(
                            value: "Vaccination Appointment",
                            size: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Properties.primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Properties.primaryColor
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Report',
                backgroundColor: Properties.primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
                backgroundColor: Properties.primaryColor
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
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
