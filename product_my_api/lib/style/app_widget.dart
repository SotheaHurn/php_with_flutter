import 'package:flutter/material.dart';
import 'package:product_my_api/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppWidget {
  AppBar appBar({required String title, List<Widget>? actions}) => AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      );

  Widget imageNetwork({
    required String? image,
    double? width,
    double? height,
  }) =>
      CachedNetworkImage(
        imageUrl: image.toString(),
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.image_not_supported,
          color: Colors.red,
        ),
      );

  Widget titleTextField(String title) => Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget button({
    required void Function()? onPressed,
    EdgeInsetsGeometry? padding,
    required String name,
  }) =>
      Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: AppColors.primary,
          ),
          child: Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
}
