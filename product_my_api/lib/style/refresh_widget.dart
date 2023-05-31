import 'package:flutter/material.dart';
import 'package:product_my_api/style/colors.dart';

RefreshIndicator refreshIndicator({
  required Future<void> Function() onRefresh,
  required Widget child,
}) =>
    RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: child,
    );
