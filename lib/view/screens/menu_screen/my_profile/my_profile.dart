import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/menu_screen/my_profile/personal_details.dart';

import '../../../widget/common_toolbar.dart';
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>  with SingleTickerProviderStateMixin{
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'My Profile'),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 100.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 33),
              child: Container(
                height: 50.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TabBar(
                        unselectedLabelColor: Properties.colorTextBlue,
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: Properties.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: 'Personal Details',
                          ),
                          Tab(
                            text: 'Document',
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                PersonalDetailsScreen(),
                Center(child: Text('Personal Details'),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*
   Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                         Center(child: Text('Personal Details'),),
                         Center(child: Text('Personal Details'),)
                        ],
                      ),
                    )
 */
