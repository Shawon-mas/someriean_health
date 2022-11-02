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
  static const fieldEmiratesId = "emiratesId";

  /*Slider Image*/
  static const fieldImageUrl = "imageUrl";
  static const fieldImage = "image";
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
  static const fieldServiceProvider = "serviceProvider";

  /* AppointmentId */
  static const fieldAppointmentId = "appointmentId";

  /* Healthcare */
  static const fieldHealthcareId = "healthcareId";
  static const fieldHealthcarePackageListId = "healthcarePackageListId";
  static const fieldClinicLocation = "clinicLocation";
  static const fieldHealthcarePrice = "price";

  /* vaccination */
  static const fieldLocation = "location";
  /* Covid */
  static const fieldUnified = "unified";
  static const fieldPassportIssue = "passportIssue";
  static const fieldPassportExpiration = "passportExpiration";
  
}

class DbCollections {
  static const collectionPatients = "patients";
  static const collectionImages = "images";
  static const collectionDoctors = "doctors";
  static const collectionHealthPackages= "health_packages";
  static const collectionHealthPackagesDetails= "health_packages_list";
  static const collectionAppointments = "appointments";
  static const collectionHealthcare= "healthcare";
  static const collectionVaccination= "vaccination";
  static const collectionOrderedVaccination= "orderedVaccination";
  static const collectionCovidScreeningVaccination= "covid19_screening_appionment";
  static const collectionVisaScreeningVaccination= "vis_screening_appionment";
  static const collectionNurse= "nurse";
  static const collectionReport= "reports";
}
//.collection("covid19_screening_appionment")
