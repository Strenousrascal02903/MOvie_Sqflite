import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/detail/detailController.dart';
import 'package:sqflite_favorite/Pages/search/searchController.dart';

class Searchbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Searchcontroller());
  }
}
