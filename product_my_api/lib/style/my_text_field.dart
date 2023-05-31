import 'package:flutter/material.dart';
import 'package:product_my_api/style/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  const MyTextField({super.key, this.controller, this.hintText, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 8, right: 8, bottom: 25),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey,
        ),
      ),
    );
  }
}
