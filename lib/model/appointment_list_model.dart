class AppointmentListModel {
  Doctor? doctor;
  Patient? patient;
  Appointment? appointment;

  AppointmentListModel({
    this.doctor,
    this.patient,
    this.appointment,
  });
}

class Appointment {
  final String uid;
  final String date;
  final String doctorId;
  final String file;
  final String message;
  final String patientNumber;
  final String paymentMethod;
  final String time;

  Appointment(
      {required this.uid,
      required this.date,
      required this.doctorId,
      required this.file,
      required this.message,
      required this.patientNumber,
      required this.paymentMethod,
      required this.time});
}

class Patient {
  final String uid;
  final String email;
  final String emiratesId;
  final String firstName;
  final String gender;
  final String lastName;
  final String imageUrl;
  final String nationality;
  final String passport;
  final String dob;
  final String number;

  Patient(
      {required this.email,
      required this.emiratesId,
      required this.firstName,
      required this.gender,
      required this.lastName,
      required this.imageUrl,
      required this.nationality,
      required this.uid,
      required this.passport,
      required this.number,
      required this.dob});
}

class Doctor {
  final String uid;
  final String name;
  final String image;
  final String location;
  final String title;

  Doctor(
      {required this.uid,
      required this.name,
      required this.image,
      required this.location,
      required this.title});
}
