import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: ColorPalette.card,
        surfaceTintColor: ColorPalette.card,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/search");
              },
              icon: Icon(
                Icons.search,
                color: ColorPalette.white,
                size: 32,
              ))
        ],
        title: Text(
          "Movie App",
          style: GoogleFonts.ubuntu(
            color: ColorPalette.white,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: ColorPalette.card,
      body: Obx(
        () => controller.isMobileLayout.value
            ? const MobileLayout()
            : const TabletLayout(),
      ),
    );
  }
}
