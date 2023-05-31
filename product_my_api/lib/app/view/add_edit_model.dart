import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_model_controller.dart';
import 'package:product_my_api/app/controller/model_controller.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/my_text_field.dart';

class AddEditModelScreen extends GetView<AddEditModelController> {
  const AddEditModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget()
          .appBar(title: controller.isAddModel ? 'Add Model' : 'Edit Model'),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          if (controller.nameController.text.isEmpty) {
            Get.snackbar('Error', 'Fill all');
          } else {
            openLoading();
            await controller.addEditModel().then((value) {
              closeLoading();
              if (value) {
                Get.find<ModelController>().getModel();
                Get.back();
                Get.snackbar('Success',
                    'A category have been ${controller.isAddModel ? 'added' : 'updated'}',
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
