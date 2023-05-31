import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:product_my_api/app/model/category_model.dart';
import 'package:product_my_api/value/global.dart';

class CategoryController extends GetxController
    with StateMixin<List<CategoryModel>> {
  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
    getCategory();
  }

  Future getCategory() async {
    change([], status: RxStatus.loading());
    try {
      final respone = await dio.post(
        '/get_category.php',
      );
      if (respone.statusCode == 200) {
        final listData = CategoryModel().formList(jsonDecode(respone.data));
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

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
