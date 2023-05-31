import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/model/category_model.dart';
import 'package:product_my_api/value/global.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEditCategoryController extends GetxController {
  late bool isAddCategory;
  late CategoryModel initCategoryModel;
  late RxString image;
  late TextEditingController nameController;
  late TextEditingController imageController;

  @override
  void onInit() {
    super.onInit();
    isAddCategory = Get.arguments['isAddCategory'] ?? true;
    initCategoryModel = Get.arguments['initCategoryModel'] ?? CategoryModel();
    image = (isAddCategory ? '' : initCategoryModel.image!).obs;
    nameController = TextEditingController(text: initCategoryModel.name);
    imageController = TextEditingController(text: initCategoryModel.image);
    imageController.addListener(() async {
      if (imageController.text.isNotEmpty &&
          (await canLaunchUrl(Uri.tryParse(imageController.text.trim())!))) {
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

  Future<bool> addEditCategory() async {
    try {
      final respone = await dio.post(
        isAddCategory ? '/add_category.php' : '/edit_category.php',
        data: {
          'id': initCategoryModel.id,
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

  Future<bool> deleteCategory(int id) async {
    try {
      final respone = await dio.post(
        '/delete_category.php',
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

class AddEditCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditCategoryController>(() => AddEditCategoryController());
  }
}
