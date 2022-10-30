enum ServiceProvider { Doctor, Nurse, Physiotherapist, HomeCareAssistant }

class SelectedDoctorModel {
  final String uid;
  final String name;
  final String image;
  final String location;
  final String title;
  final ServiceProvider serviceProvider;

  SelectedDoctorModel(
      {required this.uid,
      required this.name,
      required this.image,
      required this.location,
      required this.serviceProvider,
      required this.title,});
}
