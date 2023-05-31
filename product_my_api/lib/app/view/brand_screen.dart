import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_brand_controller.dart';
import 'package:product_my_api/app/controller/brand_controller.dart';
import 'package:product_my_api/app/controller/model_controller.dart';
import 'package:product_my_api/app/view/add_edit_brand.dart';
import 'package:product_my_api/app/view/model_screen.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/refresh_widget.dart';

class BrandScreen extends GetView<BrandController> {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(title: 'Brand'),
      body: controller.obx((state) {
        return refreshIndicator(
          onRefresh: controller.getBrand,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const AddEditBrandScreen(),
                    arguments: {
                      'isAddBrand': false,
                      'initBrandModel': state[index],
                    },
                    binding: AddEditBrandBinding(),
                  );
                },
                onLongPress: () {
                  Get.defaultDialog(
                    title: 'Confirm',
                    middleText: 'Are you sure to delete this Brand?',
                    buttonColor: AppColors.primary,
                    cancelTextColor: AppColors.primary,
                    confirmTextColor: Colors.white,
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () async {
                      openLoading();
                      await AddEditBrandController()
                          .deleteBrand(state[index].id!);
                      controller.getBrand();
                      closeLoading();
                      closeLoading();
                    },
                  );
                },
                onDoubleTap: () {
                  Get.to(
                    () => const ModelScreen(),
                    arguments: {'brandId': state[index].id},
                    binding: ModelBinding(),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: Row(
                    children: [
                      AppWidget().imageNetwork(
                        image: state[index].image,
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          state[index].name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddEditBrandScreen(),
            arguments: {'isAddBrand': true},
            binding: AddEditBrandBinding(),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
