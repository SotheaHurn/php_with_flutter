import 'dart:developer';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/model/supplier_model.dart';
import 'package:product_my_api/value/global.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEditSupplierController extends GetxController {
  late bool isAddSupplier;
  late SupplierModel initSupplier;

  late RxString profile;
  late TextEditingController profileUrlController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late String sex;
  late DropdownController sexDropDownCon;
  late Rx<DateTime> dob;

  @override
  void onInit() {
    super.onInit();
    isAddSupplier = Get.arguments['isAddSupplier'] ?? true;
    initSupplier = Get.arguments['initSupplier'] ?? SupplierModel();
    profile = (isAddSupplier ? '' : initSupplier.profile.toString()).obs;
    profileUrlController = TextEditingController(text: initSupplier.profile);
    nameController = TextEditingController(text: initSupplier.name);
    phoneController = TextEditingController(text: initSupplier.phone);
    sex = initSupplier.sex ?? '';
    sexDropDownCon = DropdownController();
    dob = (initSupplier.dob ?? DateTime.now()).obs;
    profileUrlController.addListener(() async {
      if (profileUrlController.text.isNotEmpty &&
          (await canLaunchUrl(
              Uri.tryParse(profileUrlController.text.trim())!))) {
        profile(profileUrlController.text.trim());
      } else {
        profile('');
      }
    });
  }

  @override
  void dispose() {
    profileUrlController.dispose();
    nameController.dispose();
    sexDropDownCon.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<bool> addEditSupplier() async {
    try {
      final respone = await dio.post(
        isAddSupplier ? '/add_supplier.php' : '/edit_supplier.php',
        data: {
          'id': initSupplier.id,
          'profile': profile.value,
          'name': nameController.text.trim(),
          'sex': sex,
          'dob': dob.value.toString(),
          'phone': phoneController.text.trim(),
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

  Future<bool> deleteSupplier(int id) async {
    try {
      final respone = await dio.post(
        '/delete_supplier.php',
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

class AddEditSupplierBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditSupplierController>(() => AddEditSupplierController());
  }
}
