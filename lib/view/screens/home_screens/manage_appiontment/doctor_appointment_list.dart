import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/doctor_appointment_list_controller.dart';
import '../../../../global/properties.dart';
import '../../../widget/text_widget.dart';
class DoctorAppointmentList extends StatelessWidget {
  const DoctorAppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorAppointmentListController controller=Get.put(DoctorAppointmentListController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
             // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height: 40.h,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.list.length,
              itemBuilder: (context, index){
                return Obx(() => InkWell(
                  onTap: (){
                    controller.selectIndex.value=index;
                    controller.selectStatus.value=index;
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 05,
                                    color: Colors.black12,
                                    offset: Offset(2, 2))
                              ],
                              color: controller.selectStatus.value == index
                                  ? Properties.primaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: TextWidget(
                                  edgeInsetsGeometry: EdgeInsets.zero,
                                  value: controller.list[index],
                                  textColor: controller.selectStatus.value == index
                                      ? Colors.white
                                      : Colors.black,

                                  size: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                        ),
                      )
                    ],
                  ),
                ));
    },
              ),
            ),
           /* Obx(() => controller.selectIndex.value==0
                ?Center(child: Text('Showing Pending List'),)
                :Center(child: Text('Showing Confirmed List'),)
            )*/
          ],
        ),
      )
      );
  }
}
