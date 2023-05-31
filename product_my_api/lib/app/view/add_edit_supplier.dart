import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:product_my_api/app/controller/add_edit_supplier_controller.dart';
import 'package:product_my_api/app/controller/supplier_controller.dart';
import 'package:product_my_api/style/app_widget.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:product_my_api/style/loading.dart';
import 'package:product_my_api/style/my_text_field.dart';

class AddEditSupplierScreen extends GetView<AddEditSupplierController> {
  const AddEditSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget().appBar(title: 'Add Supplier'),
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
                          controller.profile.isEmpty
                              ? 'https://cdn-icons-png.flaticon.com/512/3106/3106773.png'
                              : controller.profile.value,
                          maxHeight: controller.profile.isEmpty ? 50 : null,
                          errorListener: () {
                            controller.profile('');
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
              controller: controller.profileUrlController,
            ),
            AppWidget().titleTextField('Name'),
            MyTextField(
              controller: controller.nameController,
            ),
            AppWidget().titleTextField('Gender'),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                child: CoolDropdown(
                  defaultItem: controller.sex.isEmpty
                      ? null
                      : CoolDropdownItem(
                          label: controller.sex,
                          value: controller.sex,
                          icon: const Icon(Icons.male_rounded),
                        ),
                  dropdownList: [
                    CoolDropdownItem(
                      label: 'Male',
                      value: 'Male',
                      icon: const Icon(Icons.male_rounded),
                    ),
                    CoolDropdownItem(
                      label: 'Female',
                      value: 'Female',
                      icon: const Icon(Icons.female_rounded),
                    ),
                  ],
                  controller: controller.sexDropDownCon,
                  onChange: (value) {
                    controller.sex = value;
                    controller.sexDropDownCon.close();
                  },
                ),
              ),
            ),
            AppWidget().titleTextField('Date of Birth'),
            Obx(
              () => AppWidget().button(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: Get.height * 0.35,
                        child: CupertinoDatePicker(
                          onDateTimeChanged: (value) {
                            controller.dob(value);
                          },
                          minimumYear: DateTime.now().year - 100,
                          maximumYear: DateTime.now().year,
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: controller.dob.value,
                          backgroundColor: Colors.white,
                        ),
                      );
                    },
                  );
                },
                name: DateFormat(DateFormat.YEAR_MONTH_DAY)
                    .format(controller.dob.value),
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15),
              ),
            ),
            AppWidget().titleTextField('Phone'),
            MyTextField(
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppWidget().button(
        onPressed: () async {
          if (controller.profileUrlController.text.isEmpty ||
              controller.nameController.text.isEmpty ||
              controller.sex == '' ||
              controller.phoneController.text.isEmpty) {
            Get.snackbar('Error', 'Fill all');
          } else {
            openLoading();
            await controller.addEditSupplier().then((value) {
              closeLoading();
              if (value) {
                Get.find<SupplierController>().getSupplier();
                Get.back();
                Get.snackbar('Success',
                    'A category have been ${controller.isAddSupplier ? 'added' : 'updated'}',
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
