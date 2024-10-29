import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_favorite/Pages/search/searchController.dart';
import 'package:sqflite_favorite/api/movie_api.dart';
import 'package:sqflite_favorite/material/color.dart';
import 'package:sqflite_favorite/model/appConstant.dart';
import 'package:sqflite_favorite/model/movie_model.dart';

class Searchview extends StatelessWidget {
  const Searchview({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final Searchcontroller controller = Get.put(Searchcontroller());

    return Scaffold(
      backgroundColor: ColorPalette.card,
      appBar: AppBar(
        backgroundColor: ColorPalette.card,
        title: Text(
          "Search",
          style: GoogleFonts.ubuntu(color: ColorPalette.white),
        ),
        iconTheme: IconThemeData(color: ColorPalette.white),
      ),
      body: Container(
        height: heightScreen,
        width: widthScreen,
        child: Column(
          children: [
            // TextField untuk pencarian
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                onSubmitted: (value) {
                  controller.searchMovies(value);
                  print("abjsbdasdkajsdbkasjdbksd");
                },
                showCursor: true,
                cursorOpacityAnimates: true,
                enableInteractiveSelection: false,
                cursorColor: ColorPalette.white,
                decoration: InputDecoration(
                  hintText: 'Search Movies',
                  filled: true,
                  fillColor: ColorPalette.carddark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: ColorPalette.white),
                  hintStyle: GoogleFonts.ubuntu(color: ColorPalette.white),
                ),
                style: GoogleFonts.ubuntu(color: ColorPalette.white),
              ),
            ),
            // Gunakan Obx untuk mendengarkan perubahan pada searchResults
            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: ColorPalette.white,
                  )),
                );
              }
              print("yayayaayayayya");
              print(controller.searchResults);
              return controller.searchResults.isNotEmpty
                  ? Expanded(
                      flex: 13,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 110),
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final data = controller.searchResults[index];
                          final image =
                              "${AppConstant.imageurl}${data.posterPath}";

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                '/detail',
                                arguments: Movie(
                                  id: data.id,
                                  title: data.title,
                                  image: image,
                                  overview: data.overview,
                                  release: data.releaseDate,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.carddark,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: [
                                    // Poster film
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: widthScreen * 0.5,
                                        height: heightScreen * 0.14,
                                        foregroundDecoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(image),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Judul
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            data.title,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.ubuntu(
                                              color: ColorPalette.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: Text(
                        "Data tidak ditemukan",
                        style: GoogleFonts.ubuntu(
                          color: ColorPalette.white,
                          fontSize: 24,
                        ),
                      )),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
