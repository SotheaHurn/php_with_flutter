import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/model/model_model.dart';
import 'package:product_my_api/value/global.dart';

class AddEditModelController extends GetxController {
  late bool isAddModel;
  late ModelModel initModel;
  late int brandId;
  late TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    isAddModel = Get.arguments['isAddModel'] ?? true;
    initModel = Get.arguments['initModel'] ?? ModelModel();
    brandId = Get.arguments['brandId'];
    nameController = TextEditingController(text: initModel.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<bool> addEditModel() async {
    try {
      final respone = await dio.post(
        isAddModel ? '/add_model.php' : '/edit_model.php',
        data: {
          'id': initModel.id,
          'name': nameController.text.trim(),
          'brand_id': brandId,
        },
      );
      if (respone.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
    return false;
  }

  Future<bool> deleteModel(int id) async {
    try {
      final respone = await dio.post(
        '/delete_model.php',
        data: {'id': id},
      );
      if (respone.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
    return false;
  }
}

class AddEditModelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditModelController>(() => AddEditModelController());
  }
}
