import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:product_my_api/app/model/product_model.dart';
import 'package:product_my_api/value/global.dart';

class HomeController extends GetxController {
  final RxList<ProductModel> _listProduct = <ProductModel>[].obs;
  List<ProductModel> get listProduct => _listProduct.toList();

  @override
  void onReady() {
    super.onReady();
    getProduct();
  }

  Future getProduct() async {
    try {
      final response = await dio.post('/get_product_pdo.php');
      if (response.statusCode == 200) {
        _listProduct(
          ProductModel().formList(
            jsonDecode(response.data),
          ),
        );
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
