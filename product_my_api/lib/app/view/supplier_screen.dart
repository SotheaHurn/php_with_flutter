import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:product_my_api/app/controller/add_edit_supplier_controller.dart';
import 'package:product_my_api/app/controller/supplier_controller.dart';
import 'package:product_my_api/app/view/add_edit_supplier.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';

class SupplierScreen extends GetView<SupplierController> {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(title: 'Supplier'),
      body: controller.obx(
        (state) => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state!.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => const AddEditSupplierScreen(),
                  arguments: {
                    'isAddSupplier': false,
                    'initSupplier': state[index],
                  },
                  binding: AddEditSupplierBinding(),
                );
              },
              onLongPress: () {
                Get.defaultDialog(
                  title: 'Confirm',
                  middleText: 'Are you sure to delete this Supplier?',
                  buttonColor: AppColors.primary,
                  cancelTextColor: AppColors.primary,
                  confirmTextColor: Colors.white,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () async {
                    openLoading();
                    await AddEditSupplierController()
                        .deleteSupplier(state[index].id!);
                    controller.getSupplier();
                    closeLoading();
                    closeLoading();
                  },
                );
              },
              child: Row(
                children: [
                  AppWidget().imageNetwork(
                    image: state[index].profile,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state[index].name.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'DOB: ${DateFormat('dd MMMM,yyyy').format(state[index].dob!)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          state[index].phone.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddEditSupplierScreen(),
            arguments: {'isAddSupplier': true},
            binding: AddEditSupplierBinding(),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
