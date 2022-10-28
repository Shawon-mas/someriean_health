import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import 'health_tools.dart';
class HealthTip extends StatefulWidget {
  const HealthTip({Key? key}) : super(key: key);

  @override
  State<HealthTip> createState() => _HealthTipState();
}

class _HealthTipState extends State<HealthTip>  with SingleTickerProviderStateMixin {
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
      appBar: CommonToolbar(title: "Health Tip"),
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
                          text: 'Health Tools',
                        ),
                        Tab(
                          text: 'Health Blog',
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
                HealthTools(),
                Center(
                  child: Text('Health Blog'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
