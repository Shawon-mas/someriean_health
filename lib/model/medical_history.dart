class MEDICALHISTORY{
  String? date;
  String? name;
  String? problem;
  String? schedule;
  String? doctor;
  String? location;

  MEDICALHISTORY({this.date, this.name, this.problem,this.schedule,this.doctor,  this.location});
}

List<MEDICALHISTORY> recordsList=[
  MEDICALHISTORY(
      date: '04 January 2022',
      name: 'ENT',
      problem: 'Sore throat',
      schedule: 'Scheduled at 10:30 am',
      doctor: 'Doctor Seen: Mohamad Ejaz, MD',
      location: 'Somerian Clinic, Dubai'
  ),
  MEDICALHISTORY(
      date: '21 August 2021',
      name: 'Cardiologist',
      problem: 'Circulatory problems',
      schedule: 'Scheduled at 4:45 pm',
      doctor: 'Doctor Seen: ohn Paul George, MD',
      location: 'Somerian Clinic, Dubai'
  ),


];