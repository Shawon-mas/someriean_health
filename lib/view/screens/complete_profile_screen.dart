import 'package:flutter/material.dart';
import 'package:somerian_health/view/widget/common_toolbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/text_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
   DateTime? selectedDate ;

  _selectDate() async {
     DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year),
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));

      setState(() {
        selectedDate = picked!;
      });

  }
  String? valueChoose;
  String? valueNationality;
  final gender  =['Male','Female','Others'];
  final nationality  =['Afghan','Albanian','Emirati','Bangladeshi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Complete your profile',),
      body: Column(
        children: [

          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 40.h,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextWidget(value: "Please provide basic detalis",size: 14.sp,fontWeight: FontWeight.w700,textColor: Colors.black,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                        ),

                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    _selectDate();
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 40.h,
                    width: double.infinity,
                    child: Row(
                      children: [
                        selectedDate==null?
                        TextWidget(value: "Date of Birth",size: 14.sp,fontWeight: FontWeight.w700,textColor: Colors.grey,)
                            :TextWidget(value: '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}',size: 14.sp,fontWeight: FontWeight.w700,textColor: Colors.grey,),
                        Spacer(),
                        Icon(Icons.calendar_today,color:Colors.grey ,)

                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Mobile No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: DropdownButton(
                    hint: Text('Gender'),
                    isExpanded: true,
                    value: valueChoose,
                    underline: SizedBox(),
                    onChanged: (newValue){
                      setState(() {
                        valueChoose=newValue as String? ;
                      });
                    },
                    items: gender.map((valuItem){
                      return DropdownMenuItem(
                          value: valuItem,
                          child: Text(valuItem),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: DropdownButton(
                    hint: Text('Nationality'),
                    isExpanded: true,
                    value: valueNationality,
                    underline: SizedBox(),
                    onChanged: (newValue){
                      setState(() {
                        valueNationality=newValue as String? ;
                      });
                    },
                    items: nationality.map((valuItem){
                      return DropdownMenuItem(
                        value: valuItem,
                        child: Text(valuItem),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Emirates ID/Passport No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black54, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}
