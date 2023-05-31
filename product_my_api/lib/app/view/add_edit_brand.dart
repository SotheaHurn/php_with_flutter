import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_brand_controller.dart';
import 'package:product_my_api/app/controller/brand_controller.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/my_text_field.dart';

class AddEditBrandScreen extends GetView<AddEditBrandController> {
  const AddEditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget()
          .appBar(title: controller.isAddBrand ? 'Add Brand' : 'Edit Brand'),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
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
                              ? 'https://cdn-icons-png.flaticon.com/512/5229/5229534.png'
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
            const SizedBox(height: 15),
            AppWidget().titleTextField('Image Url'),
            MyTextField(
              hintText: 'Image Url',
              controller: controller.imageController,
            ),
            AppWidget().titleTextField('Name'),
            MyTextField(
              hintText: 'Name',
              controller: controller.nameController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppWidget().button(
        onPressed: () async {
          if (controller.image.isEmpty ||
              controller.nameController.text.isEmpty) {
            Get.snackbar('Error', 'Fill all');
          } else {
            openLoading();
            await controller.addEditBrand().then((value) {
              closeLoading();
              if (value) {
                Get.find<BrandController>().getBrand();
                Get.back();
                Get.snackbar('Success',
                    'A brand have been ${controller.isAddBrand ? 'added' : 'updated'}',
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
