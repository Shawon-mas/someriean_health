import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/general_button.dart';
import '../../../widget/text_widget.dart';
class PackageDetails extends StatefulWidget {
  final String Image;
  final String Title;
  final  String docId;
  const PackageDetails({Key? key, required this.Image, required this.Title, required this.docId}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  //late var docId =widget.docId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.docId);
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference _packages_details=FirebaseFirestore.instance.collection(DbCollections.collectionHealthPackages).doc(widget.docId).collection(DbCollections.collectionHealthPackagesDetails);

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
            Expanded(
              child: StreamBuilder(
                  stream: _packages_details.snapshots(),
                  builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            final DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                children: [
                                  Container(

                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Properties.colorTextBlue),
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(
                                            value: documentSnapshot['title'],
                                            size: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            textColor: Properties.colorTextBlue,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              showPackageDetails(documentSnapshot);
                                            },
                                            child: Container(

                                              decoration: BoxDecoration(
                                                color: Properties.primaryColor,
                                              borderRadius: BorderRadius.circular(50)
                                              ),
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  }),
            ),

          ],
        ),

    );
  }

  void showPackageDetails(DocumentSnapshot<Object?> documentSnapshot) {
    showModalBottomSheet(

        context: context, builder: (context){
      return SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
             Html(data: documentSnapshot['details']),
              AppointmentButton(
                onPressed: () {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => BasicDetailsScreen()));
                },
                value: 'Book Now',
              ),
            SizedBox(height: 20,)
            /*  TextWidget(
                value: documentSnapshot['details'],
                size: 12.sp,
                fontWeight: FontWeight.w700,
                textColor: Properties.colorTextBlue,
              ),*/
            ],
          ),
        ),
      );
    });
  }
}
