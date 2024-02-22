import 'package:get/get.dart';

import 'package:sqflite_favorite/Pages/home/homePageController.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
