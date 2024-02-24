import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/home/homePageController.dart';
import 'package:sqflite_favorite/Pages/home/widget/mobileview.dart';
import 'package:sqflite_favorite/Pages/home/widget/tabletview.dart';
import 'package:sqflite_favorite/material/color.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.background,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/favorite");
              },
              icon: Icon(
                Icons.favorite,
                color: ColorPalette.main,
              ))
        ],
      ),
      backgroundColor: ColorPalette.background,
      body: Obx(
        () => controller.isMobileLayout.value
            ? const MobileLayout()
            : const TabletLayout(),
      ),
    );
  }
}
