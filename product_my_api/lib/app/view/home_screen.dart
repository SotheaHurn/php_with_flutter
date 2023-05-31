import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/add_edit_product_controller.dart';
import 'package:product_my_api/app/controller/brand_controller.dart';
import 'package:product_my_api/app/controller/category_controller.dart';
import 'package:product_my_api/app/controller/home_controller.dart';
import 'package:product_my_api/app/controller/model_controller.dart';
import 'package:product_my_api/app/controller/supplier_controller.dart';
import 'package:product_my_api/app/view/add_edit_product.dart';
import 'package:product_my_api/app/view/brand_screen.dart';
import 'package:product_my_api/app/view/category_screen.dart';
import 'package:product_my_api/app/view/model_screen.dart';
import 'package:product_my_api/app/view/supplier_screen.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:intl/intl.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/refresh_widget.dart';
import 'package:product_my_api/value/enum.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(
        title: 'Products',
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: EnumMenuAddProductProperties.addCategory.value,
                    child: const Text('Category'),
                  ),
                  PopupMenuItem<int>(
                    value: EnumMenuAddProductProperties.addBrand.value,
                    child: const Text('Brand'),
                  ),
                  PopupMenuItem<int>(
                    value: EnumMenuAddProductProperties.supplier.value,
                    child: const Text('Supplier'),
                  ),
                ];
              },
              onSelected: (value) {
                if (EnumMenuAddProductProperties.addProduct.value == value) {
                } else if (EnumMenuAddProductProperties.addCategory.value ==
                    value) {
                  Get.to(
                    () => const CategoryScreen(),
                    binding: CategoryBinding(),
                  );
                } else if (EnumMenuAddProductProperties.addBrand.value ==
                    value) {
                  Get.to(
                    () => const BrandScreen(),
                    binding: BrandBinding(),
                  );
                } else if (EnumMenuAddProductProperties.addModel.value ==
                    value) {
                  Get.to(
                    () => const ModelScreen(),
                    binding: ModelBinding(),
                  );
                } else if (EnumMenuAddProductProperties.supplier.value ==
                    value) {
                  Get.to(
                    () => const SupplierScreen(),
                    binding: SupplierBinding(),
                  );
                }
              }),
        ],
      ),
      body: refreshIndicator(
          child: SafeArea(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.listProduct.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.to(
                        () => const AddEditProductScreen(),
                        arguments: {
                          'isAddProduct': false,
                          'initProduct': controller.listProduct[index],
                        },
                        binding: AddEditProductBinding(),
                      );
                    },
                    onLongPress: () {
                      Get.defaultDialog(
                        title: 'Confirm',
                        middleText: 'Are you sure to delete this Product?',
                        buttonColor: AppColors.primary,
                        cancelTextColor: AppColors.primary,
                        confirmTextColor: Colors.white,
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () async {
                          openLoading();
                          await AddEditProductController()
                              .deleteProduct(controller.listProduct[index].id!);
                          controller.getProduct();
                          closeLoading();
                          closeLoading();
                        },
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.03),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              AppWidget().imageNetwork(
                                image: controller.listProduct[index].image
                                    .toString(),
                                width: 140,
                                height: 140,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.listProduct[index].name
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (controller
                                            .listProduct[index].supplierName !=
                                        null)
                                      Text(
                                        'Supplier : ${controller.listProduct[index].supplierName}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    Text(
                                      'Category : ${controller.listProduct[index].categoryName}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      'Brand : ${controller.listProduct[index].brandName}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      'Model : ${controller.listProduct[index].modelName}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      NumberFormat('\$ ###,###.##').format(
                                          controller.listProduct[index].price),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
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
                ),
              ),
            ),
          ),
          onRefresh: controller.getProduct),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddEditProductScreen(),
            arguments: {'isAddProduct': true},
            binding: AddEditProductBinding(),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
