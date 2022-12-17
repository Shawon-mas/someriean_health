import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../widget/text_widget.dart';
class HealthBlog extends StatelessWidget {
  const HealthBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _blog =
    FirebaseFirestore.instance.collection(DbCollections.collectionHealthBlog);
    return Expanded(
      child: StreamBuilder(
        stream: _blog.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =snapshot.data!.docs[index];

                    return InkWell(
                      onTap: () {},
                      child: doctorsList(documentSnapshot, context),
                    );


                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  Widget doctorsList(
      DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        edgeInsetsGeometry: EdgeInsets.zero,
                        value: documentSnapshot['title'],
                        size: 16.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Properties.colorTextBlue,
                      ),
                      SizedBox(height: 5.h,),
                      TextWidget(
                        edgeInsetsGeometry: EdgeInsets.zero,
                        value: documentSnapshot['short'],
                        size: 14.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Properties.fontColor,
                      ),
                      SizedBox(height: 5.h,),
                      InkWell(
                        onTap: (){

                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              edgeInsetsGeometry: EdgeInsets.zero,
                              value: 'Read more',
                              size: 15.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Properties.primaryColor,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,color: Properties.primaryColor,size: 15,),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Image.network(
                    documentSnapshot['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Divider()
              ],
            ),
          ),


        ],
      ),
    );
  }
}
