import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/epharmacy_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
class ItemDetails extends StatelessWidget {
  final EpharmacyController controller;
  const ItemDetails({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: controller.selectedItem.name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag:'item',
            child: Image.network(
              controller.selectedItem.image,
              height: 250.h,
              width: double.maxFinite,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  edgeInsetsGeometry: EdgeInsets.all(3),
                  value: 'Price: ${controller.selectedItem.price} AED',
                  size: 20.sp,
                  fontWeight: FontWeight.w300,
                  textColor: Properties.colorTextBlue,
                ),
                TextWidget(
                  edgeInsetsGeometry: EdgeInsets.all(3),
                  value: controller.selectedItem.name,
                  size: 20.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Properties.colorTextBlue,
                ),

                TextWidget(
                  edgeInsetsGeometry: EdgeInsets.all(3),
                  value: 'Type: ${controller.selectedItem.type} ',
                  size: 20.sp,
                  fontWeight: FontWeight.w500,
                  textColor: Properties.colorTextBlue,
                ),
                Html(data: controller.selectedItem.description,
                  style: {
                    "body":Style(
                        fontSize: FontSize(18.0),
                        fontWeight: FontWeight.w500,
                        color: Properties.colorTextBlue
                    )
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
