import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:product_my_api/app/model/model_model.dart';
import 'package:product_my_api/value/global.dart';

class ModelController extends GetxController with StateMixin<List<ModelModel>> {
  late int brandId;

  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
    brandId = Get.arguments['brandId'];
  }

  @override
  void onReady() {
    super.onReady();
    getModel();
  }

  Future getModel() async {
    change([], status: RxStatus.loading());
    try {
      final respone =
          await dio.post('/get_model.php', data: {'brand_id': brandId});
      if (respone.statusCode == 200) {
        final listData = ModelModel().formList(jsonDecode(respone.data));
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

class ModelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelController>(() => ModelController());
  }
}
