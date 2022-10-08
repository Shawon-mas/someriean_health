
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryDoctors{
  getDoctors(String title){
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('title', isEqualTo: title)
        .get();
  }
}