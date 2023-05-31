import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:product_my_api/app/model/supplier_model.dart';
import 'package:product_my_api/value/global.dart';

class SupplierController extends GetxController
    with StateMixin<List<SupplierModel>> {
  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
    getSupplier();
  }

  Future getSupplier() async {
    change([], status: RxStatus.loading());
    try {
      final respone = await dio.post('/get_supplier.php');
      if (respone.statusCode == 200) {
        final listData = SupplierModel().formList(jsonDecode(respone.data));
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

class SupplierBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierController>(() => SupplierController());
  }
}
