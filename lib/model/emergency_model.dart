class EmergencyModel{
  String? image;
  String? name;
  String? number;

  EmergencyModel({this.image, this.name, this.number});
}
List<EmergencyModel> emergency_model=[
  EmergencyModel(
    image:'assets/images/police.png',
    name: 'Police',
    number: '999'
  ),
  EmergencyModel(
      image:'assets/images/ambulance.png',
      name: 'Ambulance',
      number: '998'
  ),
  EmergencyModel(
      image:'assets/images/fire.png',
      name: 'Fire Department',
      number: '997'
  ),
  EmergencyModel(
      image:'assets/images/coast_guard.png',
      name: 'Coastguard',
      number: '996'
  ),
  EmergencyModel(
      image:'assets/images/plug.png',
      name: 'Electricity Failure',
      number: '991'
  ),
  EmergencyModel(
      image:'assets/images/water_tap.png',
      name: 'Water Failure',
      number: '922'
  ),

];