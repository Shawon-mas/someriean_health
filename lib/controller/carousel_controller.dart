import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/carousel.dart';
import '../services/banner_service.dart';

class CarouselController extends GetxController {
  static CarouselController instance = Get.find();
  RxList<CarouselModel> carouselItemList = List<CarouselModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    try {
      isLoading(true);
      var result = await BannerService().getBanners();
      carouselItemList.assignAll(result);
    }catch(e) {
      debugPrint(e.toString());
    }finally {
      isLoading(false);
    }
  }
}