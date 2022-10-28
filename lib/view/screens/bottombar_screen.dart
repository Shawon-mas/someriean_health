
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import 'package:somerian_health/global/properties.dart';

import 'bottom_screens/home.dart';
import 'bottom_screens/menu.dart';
import 'bottom_screens/search.dart';
import 'home_screens/doctors_menu_screens/doctors_menu.dart';
import 'home_screens/reports/reports_type.dart';




class BottomBarScreen extends StatefulWidget {
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //final _controller = Get.put(CarouselController());
  /*final List<String> imageList = [
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
  ];*/
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions=[
    HomeScreen(),
    Search(),
    ReportsType(),
    MenuScreen(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FluentSystemIcons.ic_fluent_home_filled,
            ),
            label: 'Home',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_search_filled,),
            label: 'Search',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_info_filled,),
              label: 'Report',
              backgroundColor: Properties.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_navigation_filled,),
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


