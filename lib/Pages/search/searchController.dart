import 'package:get/get.dart';
import 'package:sqflite_favorite/api/movie_api.dart';
import 'package:sqflite_favorite/model/ProductResponModel.dart';
import 'package:sqflite_favorite/model/movie_model.dart';

class Searchcontroller extends GetxController {
  final MovieApi apiController = Get.put(MovieApi());
  RxBool isLoading = false.obs;
  RxList<MovieModel> searchResults = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void searchMovies(String query) async {
    isLoading.value = true; // Menandai bahwa pencarian sedang berlangsung
    try {
      searchResults.value = await apiController.loadDataSearch(query);
    } catch (e) {
      print("Error searching movies: $e");
      searchResults.value = []; // Kosongkan hasil pencarian jika terjadi error
    } finally {
      isLoading.value = false; // Set loading ke false setelah pencarian selesai
    }
  }
}
