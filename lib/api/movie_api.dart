import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite_favorite/model/DetailResponseModel.dart';
import 'package:sqflite_favorite/model/ProductResponModel.dart';
import 'package:sqflite_favorite/model/movie_model.dart';

class MovieApi extends GetxController {
  RxList<MovieModel> resultctr = <MovieModel>[].obs;
  RxList<MovieModel> resultsearchctr = <MovieModel>[].obs;
  RxList<MovieModel> resultctrtop = <MovieModel>[].obs;
  RxList<DetailResponseModel> detailctr = <DetailResponseModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isOffline = false.obs;

  StreamSubscription? connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    loadData();
    loadDataCategoriesUpcoming();
    startMonitoringConnectivity();
  }

  @override
  void onClose() {
    connectivitySubscription?.cancel();
    super.onClose();
  }

  loadData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=c5a08a2d246ab58398fc520d9b8ef159"));

      if (response.statusCode == 200) {
        //mengisi data dengan hasil json dari model
        // print(response.body);
        resultctr.value = movieResponseModelFromJson(response.body).results;
      } else {
        print("Status Code : ${response.statusCode}");
      }
      isLoading = false.obs;
    } catch (e) {
      print(e);
      isLoading.value =
          false; // Mengubah isLoading menjadi false jika terjadi error
    }
  }

  Future<List<MovieModel>> loadDataSearch(String query) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$query&api_key=c5a08a2d246ab58398fc520d9b8ef159"));

    if (response.statusCode == 200) {
      // Parse JSON dan ambil hasil
      return movieResponseModelFromJson(response.body)
          .results; // Pastikan fungsi ini sesuai
    } else {
      throw Exception("Failed to load movies");
    }
  }

  loadDataCategories(String categories) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/${categories}?api_key=c5a08a2d246ab58398fc520d9b8ef159"));

      if (response.statusCode == 200) {
        //mengisi data dengan hasil json dari model
        // print(response.body);
        resultctr.value = movieResponseModelFromJson(response.body).results;
      } else {
        print("Status Code : ${response.statusCode}");
      }
      isLoading = false.obs;
    } catch (e) {
      print(e);
      isLoading.value =
          false; // Mengubah isLoading menjadi false jika terjadi error
    }
  }

  loadDataCategoriesUpcoming() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=c5a08a2d246ab58398fc520d9b8ef159"));

      if (response.statusCode == 200) {
        //mengisi data dengan hasil json dari model
        // print(response.body);
        resultctrtop.value = movieResponseModelFromJson(response.body).results;
      } else {
        print("Status Code : ${response.statusCode}");
      }
      isLoading = false.obs;
    } catch (e) {
      print(e);
      isLoading.value =
          false; // Mengubah isLoading menjadi false jika terjadi error
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void startMonitoringConnectivity() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        isOffline.value = true;
        resultctr.clear();
      } else {
        isOffline.value = false;
        loadData();
      }
    });
  }
}
