import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controller/epharmacy_controller.dart';
import '../../../../global/db_paths.dart';
import '../../../../global/properties.dart';
import '../../../../model/epharmacy_model.dart';
import '../../../widget/common_toolbar.dart';
import '../../../widget/text_widget.dart';
import 'item_details.dart';

class EpharmacyList extends StatefulWidget {
  const EpharmacyList({Key? key}) : super(key: key);

  @override
  State<EpharmacyList> createState() => _EpharmacyListState();
}

class _EpharmacyListState extends State<EpharmacyList> {
  final CollectionReference _item = FirebaseFirestore.instance.collection(DbCollections.collectionEpharmaItem);
  String name = "";
  final _controller = Get.put(EpharmacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonToolbar(title: 'E-Pharma'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
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
                    prefixIcon: Icon(Icons.search, color: Properties.colorTextBlue),
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 18.sp, color: Properties.colorTextBlue),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white))),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _item.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> searchSnapshots = [];
                  if (name.isEmpty) {
                    return _gridBuilder(snapshot.data!.docs);
                  } else if (name.isNotEmpty) {
                    for (var data in snapshot.data!.docs) {
                      if (data['name'].toString().toLowerCase().contains(name.toLowerCase())) {
                        searchSnapshots.add(data);
                      }
                    }
                    return _gridBuilder(searchSnapshots);
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  GridView _gridBuilder(List<DocumentSnapshot> snapshots) {
    return GridView.builder(
        itemCount: snapshots.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 350 / 320,
        ),
        itemBuilder: (context, index) {
          return _gridItem(snapshots[index], context);
        });
  }

  Padding _searchedItem(DocumentSnapshot<Object?> documentSnapshot) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'item',
              child: Image.network(
                documentSnapshot['image'],
                height: 70.h,
                width: 150.w,
                fit: BoxFit.contain,
              ),
            ),
            TextWidget(
              edgeInsetsGeometry: EdgeInsets.all(3),
              value: documentSnapshot['name'],
              size: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: Properties.colorTextBlue,
            ),
            TextWidget(
              edgeInsetsGeometry: EdgeInsets.all(3),
              value: '${documentSnapshot['price']} AED',
              size: 14.sp,
              fontWeight: FontWeight.w300,
              textColor: Properties.colorTextBlue,
            )
          ],
        ),
      ),
    );
  }

  InkWell _gridItem(DocumentSnapshot<Object?> documentSnapshot, BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.selectedItem = EmpharmacyModel(
          uid: documentSnapshot.id,
          name: documentSnapshot['name'],
          image: documentSnapshot['image'],
          price: documentSnapshot['price'],
          type: documentSnapshot['type'],
          description: documentSnapshot['description'],
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetails(
              controller: _controller,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'item',
                  child: Image.network(
                    documentSnapshot['image'],
                    height: 70.h,
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
                ),
                TextWidget(
                  edgeInsetsGeometry: EdgeInsets.all(3),
                  value: documentSnapshot['name'],
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Properties.colorTextBlue,
                ),
                TextWidget(
                  edgeInsetsGeometry: EdgeInsets.all(3),
                  value: '${documentSnapshot['price']} AED',
                  size: 14.sp,
                  fontWeight: FontWeight.w500,
                  textColor: Properties.colorTextBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
