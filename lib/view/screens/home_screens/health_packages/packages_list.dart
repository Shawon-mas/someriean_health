import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somerian_health/global/properties.dart';
import 'package:somerian_health/view/screens/home_screens/health_packages/package_details.dart';

import '../../../../global/db_paths.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';

class PackagesListScreen extends StatefulWidget {
  const PackagesListScreen({Key? key}) : super(key: key);

  @override
  State<PackagesListScreen> createState() => _PackagesListScreenState();
}

class _PackagesListScreenState extends State<PackagesListScreen> {
  final CollectionReference _packages = FirebaseFirestore.instance
      .collection(DbCollections.collectionHealthPackages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'Health Packages'),
      body: StreamBuilder(
          stream: _packages.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 110.h,
                            child: Stack(
                              children: [
                                Image.network(
                                  documentSnapshot['image'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 60.h,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextWidget(
                                          value: documentSnapshot['name'],
                                          size: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.white60,
                                            Properties.primaryColor,
                                          ])),
                                    )
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PackageDetails(
                                            image: documentSnapshot['image'],
                                            title: documentSnapshot['name'],
                                            docId: documentSnapshot.id,
                                          )));
                            },
                            child: Row(
                              children: [
                                TextWidget(
                                  value: documentSnapshot['package'],
                                  size: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: Properties.fontColor,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      value: 'Know more',
                                      size: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      textColor: Properties.primaryColor,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15.sp,
                                      color: Properties.primaryColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
