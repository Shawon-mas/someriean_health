import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
class InsuranceList extends StatefulWidget {
  const InsuranceList({Key? key}) : super(key: key);

  @override
  State<InsuranceList> createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {
  final CollectionReference _insurance = FirebaseFirestore.instance.collection(DbCollections.collectionInsurance);
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Insurance'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(),
              child: TextField(
                //  controller: searchController,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    prefixIcon: Icon(Icons.search,
                        color: Properties.colorTextBlue),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Properties.colorTextBlue),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.white))),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: StreamBuilder(
            stream: _insurance.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasData){

                  return GridView.count(
                      crossAxisCount: 2,
                     childAspectRatio: 300 / 250,
                     children: List.generate(snapshot.data!.docs.length, (index) {
                       final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                       if(name.isEmpty){
                         return Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Container(
                             decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(
                                 10,
                               ),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey.withOpacity(0.5),
                                   spreadRadius: 5,
                                   blurRadius: 7,
                                   offset: Offset(0, 3), // changes position of shadow
                                 ),
                               ],
                             ),


                             child: Image.network(
                               documentSnapshot['image'],
                               height: 100,
                               width: 100,
                               fit: BoxFit.cover,
                             ),
                           ),
                         );
                       }else if(documentSnapshot['name']
                           .toString()
                           .toLowerCase()
                           .contains(name.toLowerCase())){
                         return Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Container(
                             decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(
                                 10,
                               ),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.grey.withOpacity(0.5),
                                   spreadRadius: 5,
                                   blurRadius: 7,
                                   offset: Offset(0, 3), // changes position of shadow
                                 ),
                               ],
                             ),


                             child: Image.network(
                               documentSnapshot['image'],
                               height: 100,
                               width: 100,
                               fit: BoxFit.cover,
                             ),
                           ),
                         );
                       } else{
                         return Container();
                       }


                  }),
                  );
                }
                return Center();
              }
          )
          )
        ],
      ),

    );
  }
}
