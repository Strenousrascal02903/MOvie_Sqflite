import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteController.dart';
import 'package:sqflite_favorite/Pages/favorite/widget/mobileFavorite.dart';
import 'package:sqflite_favorite/Pages/home/homePageController.dart';
import 'package:sqflite_favorite/material/color.dart';

class Favorite extends GetView<FavoriteController> {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController layoutController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: ColorPalette.background,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() => layoutController.isMobileLayout.value
          ? MobileFavorite(favoriteController: controller)
          : MobileFavorite(favoriteController: controller)),
    );
  }
}
