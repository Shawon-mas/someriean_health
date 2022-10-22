import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class VaccinationCentreScreen extends StatefulWidget {
  const VaccinationCentreScreen({Key? key}) : super(key: key);

  @override
  State<VaccinationCentreScreen> createState() => _VaccinationCentreScreenState();
}

class _VaccinationCentreScreenState extends State<VaccinationCentreScreen> {
  final CollectionReference _doctors =
  FirebaseFirestore.instance.collection('doctors');
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
