import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/model/brand_model.dart';
import 'package:product_my_api/value/global.dart';

class AddEditBrandController extends GetxController {
  late bool isAddBrand;
  late BrandModel initBrandModel;
  late RxString image;
  late TextEditingController imageController;
  late TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    isAddBrand = Get.arguments['isAddBrand'] ?? true;
    initBrandModel = Get.arguments['initBrandModel'] ?? BrandModel();
    image = (isAddBrand ? '' : initBrandModel.image.toString()).obs;
    imageController = TextEditingController(text: initBrandModel.image);
    nameController = TextEditingController(text: initBrandModel.name);
    imageController.addListener(() async {
      if (imageController.text.isNotEmpty) {
        image(imageController.text.trim());
      } else {
        image('');
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<bool> addEditBrand() async {
    try {
      final respone = await dio.post(
        isAddBrand ? '/add_brand.php' : '/edit_brand.php',
        data: {
          'id': initBrandModel.id,
          'name': nameController.text.trim(),
          'image': image.value,
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

  Future<bool> deleteBrand(int id) async {
    try {
      final respone = await dio.post(
        '/delete_brand.php',
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

class AddEditBrandBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditBrandController>(() => AddEditBrandController());
  }
}
