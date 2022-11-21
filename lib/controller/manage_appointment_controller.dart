import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/model/appointment_list_model.dart';

class ManageAppointmentController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  var appointmentLists = <AppointmentListModel>[].obs;
  final firestore = FirebaseFirestore.instance;

  getAppointments() {
    appointmentLists.clear();
    logger.d("Here I ammm!");
    if (user != null) {
      final userNumber = user!.phoneNumber;
      //final userNumber = "+971585822900";
      //final userNumber = "+971567047205";
      firestore.collection(DbCollections.collectionAppointments).get().then((appointment) {
        for (var data in appointment.docs) {
          if (data[DbDocs.fieldPatientNumber] == userNumber) {
            if (data.data().containsKey(DbDocs.fieldServiceProvider)) {
              if (data[DbDocs.fieldServiceProvider] == "Doctor") {
                var userAppointment = Appointment(
                  uid: data.id,
                  date: data[DbDocs.fieldDate],
                  doctorId: data[DbDocs.fieldDoctorId],
                  file: data[DbDocs.fieldFile],
                  message: data[DbDocs.fieldMessage],
                  patientNumber: data[DbDocs.fieldPatientNumber],
                  paymentMethod: data[DbDocs.fieldPaymentMethod],
                  time: data[DbDocs.fieldTime],
                );
                getDoctor(data[DbDocs.fieldDoctorId], userAppointment);
              } else {
                //Nurse
              }
            } else {
              var userAppointment = Appointment(
                uid: data.id,
                date: data[DbDocs.fieldDate],
                doctorId: data[DbDocs.fieldDoctorId],
                file: data[DbDocs.fieldFile],
                message: data[DbDocs.fieldMessage],
                patientNumber: data[DbDocs.fieldPatientNumber],
                paymentMethod: data[DbDocs.fieldPaymentMethod],
                time: data[DbDocs.fieldTime],
              );
              getDoctor(data[DbDocs.fieldDoctorId], userAppointment);
            }
          }
        }
      });
    }
  }

  getDoctor(String doctorUid, Appointment appointment) {
    firestore.collection(DbCollections.collectionDoctors).doc(doctorUid).get().then(
      (doctor) {
        var userDoctor = Doctor(
          uid: doctor.id,
          name: doctor[DbDocs.fieldName],
          image: doctor[DbDocs.fieldImage],
          location: doctor[DbDocs.fieldLocation],
          title: doctor[DbDocs.fieldTitle],
        );
        appointmentLists.add(
          AppointmentListModel(
            doctor: userDoctor,
            appointment: appointment,
          ),
        );
      },
    );
  }

  deleteAppointment(String appointmentId, String doctorId, BuildContext context) {
    Get.dialog(AlertDialog(
      title: const Text('Appointment Cancellation'),
      content: const Text('Do you really want to cancel appointment?'),
      actions: [
        TextButton(
          child: const Text("No"),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: const Text("Yes"),
          onPressed: () {
            deleteFromAppointment(appointmentId).then((value) {
              deleteFromPatientAppointment(appointmentId).then((value) {
                setDoctorAppointment(appointmentId, doctorId, context);
              });
            });
          },
        ),
      ],
    ));
  }

  Future deleteFromAppointment(String appointmentId) {
    return firestore.collection(DbCollections.collectionAppointments).doc(appointmentId).delete();
  }

  Future deleteFromPatientAppointment(String appointmentId) {
    return firestore.collection(DbCollections.collectionPatients).doc(user!.phoneNumber).collection(DbCollections.collectionAppointments).doc(appointmentId).delete();
  }

  setDoctorAppointment(String appointmentId, String doctorId, BuildContext context) {
    firestore.collection(DbCollections.collectionDoctors).doc(doctorId).collection(DbCollections.collectionAppointments).doc(appointmentId).set({
      DbDocs.fieldCancelled: true,
    }).then((value) {
      successSnackBar(context, "Appointment Cancelled");
      getAppointments();
      Get.back();
    });
  }
}
