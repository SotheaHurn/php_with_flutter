import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_my_api/app/controller/home_controller.dart';
import 'package:product_my_api/app/view/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product',
      initialBinding: HomeBinding(),
      home: const HomeScreen(),
    );
  }
}
