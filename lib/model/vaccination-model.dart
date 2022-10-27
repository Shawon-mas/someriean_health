class VACCINATIONMODEL{
  String? date;
  String? dose;
  String? center;
  String? facility;
  String? location;

  VACCINATIONMODEL({this.date, this.dose, this.center, this.facility, this.location});
}

List<VACCINATIONMODEL> vaccinationList=[
  VACCINATIONMODEL(
    date: '29 January 2021',
    dose: '1st DOSE - SINOPHARM',
    center: 'DOH - SEHA',
    facility: 'Healthcare Facility',
    location: 'Dubai'
  ),
  VACCINATIONMODEL(
      date: '25 February 2021',
      dose: '2nd DOSE - SINOPHARM',
      center: 'DOH - SEHA',
      facility: 'Healthcare Facility',
      location: 'Dubai'
  ),
  VACCINATIONMODEL(
      date: '03 September 2021',
      dose: '3rd DOSE - SINOPHARM',
      center: 'DOH - SEHA',
      facility: 'Healthcare Facility',
      location: 'Abu Dubai'
  ),

];