import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:product_my_api/app/model/brand_model.dart';
import 'package:product_my_api/value/global.dart';

class BrandController extends GetxController with StateMixin<List<BrandModel>> {
  @override
  void onReady() {
    super.onReady();
    change([], status: RxStatus.success());
    getBrand();
  }

  Future getBrand() async {
    change([], status: RxStatus.loading());
    try {
      final respone = await dio.post(
        '/get_brand.php',
      );
      if (respone.statusCode == 200) {
        final listData = BrandModel().formList(jsonDecode(respone.data));
        if (listData.isEmpty) {
          return change([], status: RxStatus.empty());
        } else {
          return change(listData, status: RxStatus.success());
        }
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
    return change([], status: RxStatus.empty());
  }
}

class BrandBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandController>(() => BrandController());
  }
}
