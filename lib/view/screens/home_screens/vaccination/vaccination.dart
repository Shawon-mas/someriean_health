import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/view/screens/home_screens/vaccination/vaccination_center.dart';

import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/text_widget.dart';
class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _vaccineCenter=[
      'Sinopharm',
      'Pfizer-BioNTech',
      'Booster',

    ];
    return Scaffold(
      appBar:  CommonToolbar(title: 'Vaccination Appointment'),
      body: Column(
        children: [
          CustomContainer(value: "Select Vaccine Type"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ListView.builder(
                  itemCount: _vaccineCenter.length,
                  itemBuilder: (context,index)
                  {
                    return InkWell(
                      onTap: (){

                        if(index==0){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VaccinationCentreScreen( title: _vaccineCenter[index],)));
                        }if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VaccinationCentreScreen( title: _vaccineCenter[index],)));
                        }if(index==2){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VaccinationCentreScreen( title: _vaccineCenter[index],)));
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Properties.primaryColor,
                        ),
                        width: double.maxFinite,
                        height: 50.h,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextWidget(
                            value: _vaccineCenter[index],
                            size: 14.sp,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    );

                  }),
            ),
          ),

        ],
      ),
    );
  }
}
