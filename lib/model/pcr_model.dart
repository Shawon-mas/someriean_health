class PCRMODEL{
  String? status;
  bool? color;

  PCRMODEL({this.status, this.color});
}

List<PCRMODEL> list=[
  PCRMODEL(status:"08 Aug 2022 PCR NEGATIVE",color: true ),
  PCRMODEL(status:"09 Aug 2022 PCR NEGATIVE",color: true ),
  PCRMODEL(status:"10 Aug 2022 PCR POSITIVE",color: false ),
  PCRMODEL(status:"11 Aug 2022 PCR NEGATIVE",color: true ),
  PCRMODEL(status:"12 Aug 2022 PCR NEGATIVE",color: true ),
];