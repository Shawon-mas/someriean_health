import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class BlogDetails extends StatelessWidget {
  final String image;
  final String title;
  final String longDes;

   BlogDetails({ required this.image,   required this.title, required this.longDes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: "Health Blog"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextWidget(
                textColor: Properties.colorTextBlue,
                value: title,
                textAlign: TextAlign.center,
                size: 18.sp,
                fontWeight: FontWeight.w700,
                edgeInsetsGeometry: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 10.h,),
            Image.network(
              image,
              height: 250.h,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),

            Html(data: longDes,
              style: {
                "body":Style(
                    fontSize: FontSize(12.0),
                    fontWeight: FontWeight.w300,
                    color: Colors.black
                )
              },
            )
          ],
        ),
      ),

    );
  }
}
