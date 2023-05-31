import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_product_controller.dart';
import 'package:product_my_api/app/controller/home_controller.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/my_text_field.dart';

class AddEditProductScreen extends GetView<AddEditProductController> {
  const AddEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(
          title: controller.isAddProduct ? 'Add Product' : 'Edit Product'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Obx(
                  () => DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          controller.image.isEmpty
                              ? 'https://cdn3d.iconscout.com/3d/premium/thumb/product-5806313-4863042.png'
                              : controller.image.value,
                          maxHeight: controller.image.isEmpty ? 50 : null,
                          errorListener: () {
                            controller.image('');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppWidget().titleTextField('Image Url'),
            MyTextField(
              controller: controller.imageUrlController,
            ),
            AppWidget().titleTextField('Name'),
            MyTextField(
              controller: controller.nameController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppWidget().titleTextField('Supplier'),
                IconButton(
                  onPressed: () {
                    controller.supplierDropdownCon.resetValue();
                    controller.supplierId = null;
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: CoolDropdown(
                  dropdownList: controller.supplierList,
                  controller: controller.supplierDropdownCon,
                  onChange: (id) {
                    controller.supplierId = id;
                    controller.supplierDropdownCon.close();
                  },
                ),
              ),
            ),
            AppWidget().titleTextField('Category'),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: CoolDropdown(
                  dropdownList: controller.categoryList,
                  controller: controller.categoryDropdownCon,
                  onChange: (id) {
                    controller.categoryId = id;
                    controller.categoryDropdownCon.close();
                  },
                ),
              ),
            ),
            AppWidget().titleTextField('Brand'),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: CoolDropdown(
                  dropdownList: controller.brandList,
                  controller: controller.brandDropdownCon,
                  onChange: (id) {
                    controller.brandId = id;
                    controller.getModel();
                    controller.brandDropdownCon.close();
                  },
                ),
              ),
            ),
            AppWidget().titleTextField('Model'),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: CoolDropdown(
                  dropdownList: controller.modelList,
                  controller: controller.modelDropdownCon,
                  onChange: (id) {
                    controller.modelId = id;
                    controller.modelDropdownCon.close();
                  },
                ),
              ),
            ),
            AppWidget().titleTextField('Qty'),
            MyTextField(
              controller: controller.qtyController,
            ),
            AppWidget().titleTextField('Price'),
            MyTextField(
              controller: controller.priceController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppWidget().button(
        onPressed: () async {
          if (controller.image.isEmpty ||
              controller.nameController.text.isEmpty ||
              controller.categoryId == null ||
              controller.brandId == null ||
              controller.modelId == null ||
              controller.qtyController.text.isEmpty ||
              controller.priceController.text.isEmpty) {
            Get.snackbar('Error', 'Fill all');
          } else {
            openLoading();
            await controller.addEditProduct().then((value) {
              closeLoading();
              if (value) {
                Get.find<HomeController>().getProduct();
                Get.back();
                Get.snackbar('Success',
                    'A category have been ${controller.isAddProduct ? 'added' : 'updated'}',
                    duration: const Duration(seconds: 3));
              }
            });
          }
        },
        name: 'Save',
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      ),
    );
  }
}
