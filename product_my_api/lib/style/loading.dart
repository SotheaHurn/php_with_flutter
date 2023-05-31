import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/style/colors.dart';

Center circularProgressIndicator({double? value}) => Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          backgroundColor: Colors.transparent,
          color: AppColors.primary,
          value: value,
        ),
      ),
    );

Future<void> openLoading() async {
  await Future.delayed(Duration.zero,
      () => Get.dialog(circularProgressIndicator(), barrierDismissible: false));
}

void closeLoading() => Get.close(0);
