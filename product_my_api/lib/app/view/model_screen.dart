import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_model_controller.dart';
import 'package:product_my_api/app/controller/model_controller.dart';
import 'package:product_my_api/app/view/add_edit_model.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/refresh_widget.dart';

class ModelScreen extends GetView<ModelController> {
  const ModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(title: 'Model'),
      body: refreshIndicator(
        onRefresh: controller.getModel,
        child: controller.obx(
          (state) => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const AddEditModelScreen(),
                    arguments: {
                      'isAddModel': false,
                      'initModel': state[index],
                      'brandId': controller.brandId,
                    },
                    binding: AddEditModelBinding(),
                  );
                },
                onLongPress: () {
                  Get.defaultDialog(
                    title: 'Confirm',
                    middleText: 'Are you sure to delete this Model?',
                    buttonColor: AppColors.primary,
                    cancelTextColor: AppColors.primary,
                    confirmTextColor: Colors.white,
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () async {
                      openLoading();
                      await AddEditModelController()
                          .deleteModel(state[index].id!);
                      controller.getModel();
                      closeLoading();
                      closeLoading();
                    },
                  );
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state[index].name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddEditModelScreen(),
            arguments: {
              'isAddModel': true,
              'brandId': controller.brandId,
            },
            binding: AddEditModelBinding(),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
