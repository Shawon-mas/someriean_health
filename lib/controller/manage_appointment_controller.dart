import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:somerian_health/global/db_paths.dart';
import 'package:somerian_health/global/global_constants.dart';
import 'package:somerian_health/model/appointment_list_model.dart';

class ManageAppointmentController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  var appointmentLists = <AppointmentListModel>[].obs;

  getAppointments() {
    appointmentLists.clear();
    logger.d("Here I ammm!");
    if (user != null) {
      final userNumber = user!.phoneNumber;
      //final userNumber = "+971585822900";
      //final userNumber = "+971567047205";
      FirebaseFirestore.instance
          .collection(DbCollections.collectionAppointments)
          .get()
          .then((appointment) {
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
    FirebaseFirestore.instance
        .collection(DbCollections.collectionDoctors)
        .doc(doctorUid)
        .get()
        .then(
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

  deleteAppointment(String appointmentId) {
    /* Deleting appointment */
    /* Will do it later */
    /* After deleting we need to recall getAppointments */
    getAppointments();
  }
}
