import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../model/sliderResponse_model.dart';
import 'package:http/http.dart' as http;

import '../utilites/api_services.dart';
import '../utilites/shared_prefs.dart';

class HomeController extends GetxController{
  var sliderIndex = 0.obs;
  var sliderList = <Datum?>[].obs;
  var isSliderLoaded = true.obs;
  final _logger= Logger();

  _getSliderImages() async{
    _sliderResponseModified();
    /*var _sliderString = await SharedPrefs().getSliderResponse();
    if (_sliderString == null) {
      isSliderLoaded.value = false;
      _sliderResponse();
    } else {
      var _result = sliderModelFromJson(_sliderString);
      sliderList.value = _result!.data!;
      _sliderResponse();
    }*/
  }


  _sliderResponse() async{
    final _response = await http.get(Uri.parse(ApiServices.SLIDER_URL,),
      headers: await ApiServices().headerWithToken(),
    );
    if(_response.statusCode==200){
      isSliderLoaded.value = true;
      await SharedPrefs().storeSliderResponse(_response.body);
      var _result = sliderModelFromJson(_response.body);
      if(_result?.data !=null){
        sliderList.value=_result!.data!;
        print(_response.body);
      }
    }

  }

  _sliderResponseModified() async{
    final _response = await http.get(Uri.parse(ApiServices.SLIDER_URL),
      headers: await ApiServices().headerWithToken(),
    );
    _logger.d(_response.body);

    if(_response.statusCode==200){
      isSliderLoaded.value = true;
      final sliderModel = sliderModelFromJson(_response.body);
      //await SharedPrefs().storeSliderResponse(_response.body);
      if(sliderModel!=null){
        if(sliderModel.status!){
          sliderList.value = sliderModel.data!;
        }
      }
    }
  }
  @override
  void onInit() {
    _getSliderImages();
    // TODO: implement onInit
    super.onInit();
  }
}