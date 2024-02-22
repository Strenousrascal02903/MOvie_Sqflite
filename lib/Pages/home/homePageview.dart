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
        backgroundColor: ColorPalette.background,
        body: Obx(
          () => controller.isMobileLayout.value
              ? const MobileLayout()
              : const TabletLayout(),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              Get.toNamed("/favorite");
            },
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: ColorPalette.carddark,
                borderRadius: BorderRadius.circular(64),
              ),
              child: const Icon(
                Icons.favorite,
                color: Color(0xff00FFF5),
                size: 28,
              ),
            ),
          ),
        ));
  }
}
