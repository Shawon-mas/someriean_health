import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import 'doctor_appointment_list.dart';
import 'health_packages_appointment_list.dart';
class AppointmentSection extends StatefulWidget {
  const AppointmentSection({Key? key}) : super(key: key);

  @override
  State<AppointmentSection> createState() => _AppointmentSectionState();
}

class _AppointmentSectionState extends State<AppointmentSection> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(
        title: 'Manage Appointment',
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            child: Container(
              height: 60.h,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 6.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TabBar(
                      unselectedLabelColor: Properties.colorTextBlue,
                      labelColor: Colors.white,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2,
                      indicator: BoxDecoration(
                        color: Properties.primaryColor,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      controller: tabController,
                      tabs: [
                        Tab(
                          text: 'Doctor Appointment',
                        ),
                        Tab(
                          text: 'Health Packages Appointment',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                DoctorAppointmentList(),
                HealthPackagesAppointmentList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
