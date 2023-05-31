import 'dart:convert';
import 'dart:developer';

import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/model/brand_model.dart';
import 'package:product_my_api/app/model/category_model.dart';
import 'package:product_my_api/app/model/model_model.dart';
import 'package:product_my_api/app/model/product_model.dart';
import 'package:product_my_api/app/model/supplier_model.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/value/global.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEditProductController extends GetxController {
  late bool isAddProduct;
  late ProductModel initProduct;

  late RxString image;
  late TextEditingController imageUrlController;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController qtyController;
  int? supplierId;
  int? categoryId;
  int? brandId;
  int? modelId;
  List<CoolDropdownItem<int>> supplierList = <CoolDropdownItem<int>>[];
  List<CoolDropdownItem<int>> categoryList = <CoolDropdownItem<int>>[];
  List<CoolDropdownItem<int>> brandList = <CoolDropdownItem<int>>[];
  List<CoolDropdownItem<int>> modelList = <CoolDropdownItem<int>>[];

  late DropdownController supplierDropdownCon;
  late DropdownController categoryDropdownCon;
  late DropdownController brandDropdownCon;
  late DropdownController modelDropdownCon;

  @override
  void onInit() {
    super.onInit();
    isAddProduct = Get.arguments['isAddProduct'];
    initProduct = Get.arguments['initProduct'] ?? ProductModel();
    image = (isAddProduct ? '' : initProduct.image!).obs;
    imageUrlController = TextEditingController(text: initProduct.image);
    nameController = TextEditingController(text: initProduct.name);
    priceController = TextEditingController(
        text: initProduct.price == null ? '' : initProduct.price.toString());
    qtyController = TextEditingController(
        text: initProduct.qty == null ? '' : initProduct.qty.toString());
    supplierId = initProduct.supplierId;
    categoryId = initProduct.categoryId;
    brandId = initProduct.brandId;
    modelId = initProduct.modelId;
    imageUrlController.addListener(() async {
      if (imageUrlController.text.isNotEmpty &&
          (await canLaunchUrl(Uri.tryParse(imageUrlController.text.trim())!))) {
        image(imageUrlController.text.trim());
      } else {
        image('');
      }
    });

    supplierDropdownCon =
        DropdownController(duration: const Duration(milliseconds: 500));
    categoryDropdownCon =
        DropdownController(duration: const Duration(milliseconds: 500));
    brandDropdownCon =
        DropdownController(duration: const Duration(milliseconds: 500));
    modelDropdownCon =
        DropdownController(duration: const Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
    getProductProperties();
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    nameController.dispose();
    priceController.dispose();
    qtyController.dispose();

    supplierDropdownCon.dispose();
    categoryDropdownCon.dispose();
    brandDropdownCon.dispose();
    modelDropdownCon.dispose();
    super.dispose();
  }

  Future getProductProperties() async {
    openLoading();
    await getCategory();
    await getBrand();
    await getSupplier();
    if (brandId != null) await getModel();
    closeLoading();
  }

  Future getSupplier() async {
    try {
      final respone = await dio.post(
        '/get_supplier.php',
      );
      if (respone.statusCode == 200) {
        final listData = SupplierModel().formList(jsonDecode(respone.data));
        supplierList.assignAll(listData
            .map(
              (e) => CoolDropdownItem(
                label: e.name.toString(),
                value: e.id!,
                icon: AppWidget()
                    .imageNetwork(image: e.profile, width: 25, height: 25),
              ),
            )
            .toList());
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
  }

  Future getCategory() async {
    try {
      final respone = await dio.post(
        '/get_category.php',
      );
      if (respone.statusCode == 200) {
        final listData = CategoryModel().formList(jsonDecode(respone.data));
        categoryList.assignAll(listData
            .map(
              (e) => CoolDropdownItem(
                label: e.name.toString(),
                value: e.id!,
                icon: AppWidget()
                    .imageNetwork(image: e.image, width: 25, height: 25),
              ),
            )
            .toList());
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
  }

  Future getBrand() async {
    try {
      final respone = await dio.post(
        '/get_brand.php',
      );
      if (respone.statusCode == 200) {
        final listData = BrandModel().formList(jsonDecode(respone.data));
        brandList.assignAll(listData
            .map(
              (e) => CoolDropdownItem(
                label: e.name.toString(),
                value: e.id!,
                icon: AppWidget()
                    .imageNetwork(image: e.image, width: 25, height: 25),
              ),
            )
            .toList());
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
  }

  Future getModel() async {
    try {
      final respone =
          await dio.post('/get_model.php', data: {'brand_id': brandId});
      if (respone.statusCode == 200) {
        final listData = ModelModel().formList(jsonDecode(respone.data));
        modelList.assignAll(listData
            .map(
              (e) => CoolDropdownItem(
                label: e.name.toString(),
                value: e.id!,
              ),
            )
            .toList());
      }
    } catch (e) {
      log('error : ${e.toString()}');
    }
  }

  Future<bool> addEditProduct() async {
    try {
      //TODO has problem add product
      final respone = await dio.post(
        isAddProduct ? '/add_product_pdo.php' : '/edit_product.php',
        data: {
          'id': initProduct.id,
          'image': image.value,
          'name': nameController.text.trim(),
          'supplier_id': supplierId,
          'category_id': categoryId,
          'brand_id': brandId,
          'model_id': modelId,
          'qty': qtyController.text.trim(),
          'price': priceController.text.trim(),
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

  Future<bool> deleteProduct(int id) async {
    try {
      final respone = await dio.post(
        '/delete_product.php',
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

class AddEditProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditProductController>(() => AddEditProductController());
  }
}
