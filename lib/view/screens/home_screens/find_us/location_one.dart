import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
import '../covid19/screening_center.dart';
import '../vaccination/vaccination.dart';
import '../visa/visa_screening_center.dart';
import 'facility.dart';

class LocationOneScreen extends StatefulWidget {
  final String title;
  const LocationOneScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<LocationOneScreen> createState() => _LocationOneScreenState();
}

class _LocationOneScreenState extends State<LocationOneScreen> {
  final List selectedIndexs = [];
  @override
  Widget build(BuildContext context) {
    List<String> _center = [
      'American Crescent Health Care Centre',
      'Somerian Care Medical clinic',
      'Somerian Health Diagnostic Centre- Mafraq',
      'Somerian Health Diagnostic Centre- Musafah',
      'Mussafah Prime Assessment Center',
      'Emirates Field Hospital',
    ];

    return Scaffold(
      appBar: CommonToolbar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: _center.length,
            itemBuilder: (context, index) {
              final _isSelected = selectedIndexs.contains(index);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (_isSelected) {
                      selectedIndexs.remove(index);
                    } else {
                      selectedIndexs.add(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FacilityScreen(
                                    title: _center[index],
                                  )));
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.red, //                   <--- border color
                      width: 1.w,
                    ),
                    color:_isSelected?Properties.primaryColor: Colors.white,
                  ),
                  width: double.maxFinite,
                  height: 50.h,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextWidget(
                      value: _center[index],
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                      textColor:_isSelected?Colors.white:Properties.primaryColor,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
