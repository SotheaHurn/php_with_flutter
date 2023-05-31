import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_category_controller.dart';
import 'package:product_my_api/app/controller/category_controller.dart';
import 'package:product_my_api/app/view/add_edit_category.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/refresh_widget.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(title: 'Category'),
      body: controller.obx((state) {
        return refreshIndicator(
          onRefresh: controller.getCategory,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  Get.to(
                    () => const AddEditCategoryScreen(),
                    arguments: {
                      'isAddCategory': false,
                      'initCategoryModel': state[index],
                    },
                    binding: AddEditCategoryBinding(),
                  );
                },
                onLongPress: () {
                  Get.defaultDialog(
                    title: 'Confirm',
                    middleText: 'Are you sure to delete this Category?',
                    buttonColor: AppColors.primary,
                    cancelTextColor: AppColors.primary,
                    confirmTextColor: Colors.white,
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () async {
                      openLoading();
                      await AddEditCategoryController()
                          .deleteCategory(state[index].id!);
                      controller.getCategory();
                      closeLoading();
                      closeLoading();
                    },
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
            () => const AddEditCategoryScreen(),
            arguments: {'isAddCategory': true},
            binding: AddEditCategoryBinding(),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
