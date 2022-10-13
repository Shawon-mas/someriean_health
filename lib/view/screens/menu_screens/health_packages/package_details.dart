import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class PackageDetails extends StatefulWidget {
  final String Image;
  final String Title;
  const PackageDetails({Key? key, required this.Image, required this.Title}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonToolbar(title: widget.Title),
        body: Column(
          children: [
            Container(
              height: 150.h,
              child: Stack(
                children: [
                  Image.network(widget.Image,width: double.infinity,fit: BoxFit.cover,),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextWidget(
                            value:widget.Title,
                            size: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.white60,Properties.primaryColor,]
                            )
                        ),

                      )
                  )
                ],
              ),
            ),
          ],
        ),

    );
  }
}
