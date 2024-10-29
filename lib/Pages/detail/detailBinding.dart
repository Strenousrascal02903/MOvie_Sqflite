import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/detail/detailController.dart';

class Detailbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Detailcontroller());
  }
}