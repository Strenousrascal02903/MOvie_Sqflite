import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteBinding.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteView.dart';
import 'package:sqflite_favorite/Pages/home/homePageBinding.dart';
import 'package:sqflite_favorite/Pages/home/homePageview.dart';
import 'package:sqflite_favorite/api/movie_api.dart';
import 'package:sqflite_favorite/db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MovieApi());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/home",
      getPages: [
        GetPage(
            name: "/home",
            page: () => const HomeView(),
            binding: Homebinding()),
       GetPage(
            name: "/favorite",
            page: () => const Favorite(),
            binding: FavoriteBinding()),
      ],
    );
  }
}