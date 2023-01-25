import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
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
              IconlyLight.home,
            ),
            label: 'Home',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.search,
            ),
            label: 'Search',
            backgroundColor: Properties.primaryColor,
          ),
          BottomNavigationBarItem(icon: Icon(IconlyLight.paper), label: 'Report', backgroundColor: Properties.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.profile,
              ),
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
//ed1c24
