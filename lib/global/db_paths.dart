class DbDocs {
  static const fieldName = "name";
  static const fieldToken = "token";

  /* Complete Profile */
  static const fieldUID = "uid";
  static const fieldFirstName = "firstName";
  static const fieldLastName = "lastName";
  static const fieldDob = "dob";
  static const fieldDobMillSec = "dobMillSec";
  static const fieldNumber = "number";
  static const fieldEmail = "email";
  static const fieldGender = "gender";
  static const fieldNationality = "nationality";
  static const fieldPassport = "passport";

  /*Slider Image*/
  static const fieldImageUrl = "imageUrl";
  static const fieldUrl = "url";
  static const fieldTitle = "title";

  /* Appointment */
  static const fieldDoctorId = "doctorId";
  static const fieldPatientNumber = "patientNumber";
  static const fieldPaymentMethod = "paymentMethod";
  static const fieldFile = "file";
  static const fieldMessage = "message";
  static const fieldTime = "time";
  static const fieldDate = "date";
  static const fieldDateEpoch = "dateEpoch";
  /* AppointmentId */
  static const fieldAppointmentId = "appointmentId";
}

class DbCollections {
  static const collectionPatients = "patients";
  static const collectionImages = "images";
  static const collectionDoctors = "doctors";
  static const collectionHealthPackages= "health_packages";
  static const collectionAppointments = "appointments";
}
