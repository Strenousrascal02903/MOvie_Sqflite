import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteController.dart';

import 'package:sqflite_favorite/api/movie_api.dart';
import 'package:sqflite_favorite/material/color.dart';
import 'package:sqflite_favorite/model/appConstant.dart';
import 'package:sqflite_favorite/model/movie_model.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final FavoriteController movieController = Get.put(FavoriteController());
    final MovieApi apiController = Get.put(MovieApi());
    return Obx(() {
      if (apiController.isOffline.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_statusbar_connected_no_internet_4,
                size: 72,
                color: ColorPalette.main,
              ),
              SizedBox(height: 20),
              Text(
                'No Internet Connection , Please Connect to Internet',
                style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: ColorPalette.main),
              ),
            ],
          ),
        );
      }
      return apiController.resultctr.isEmpty &&
              apiController.resultctrtop.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: ColorPalette.white,
              ),
            )
          : Container(
              color: ColorPalette.card,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widthScreen,
                    height: heightScreen * 0.1,
                    decoration: BoxDecoration(
                        color: ColorPalette.card,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            apiController.loadDataCategories("now_playing");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.carddark,
                            foregroundColor: ColorPalette.white,
                            fixedSize:
                                const Size(120, 20), // Ukuran button 60x20
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            "Now Playing",
                            style: GoogleFonts.ubuntu(
                              color: ColorPalette.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Spacer antar tombol
                        ElevatedButton(
                          onPressed: () {
                            apiController.loadDataCategories("popular");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.carddark,
                            foregroundColor: ColorPalette.white,
                            fixedSize:
                                const Size(120, 20), // Ukuran button 60x20
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            "Popular",
                            style: GoogleFonts.ubuntu(
                              color: ColorPalette.white,
                              fontSize: 14,
                            ),
                          ), // Sesuaikan ukuran teks jika diperlukan
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            apiController.loadData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.carddark,
                            foregroundColor: ColorPalette.white,
                            fixedSize:
                                const Size(120, 20), // Ukuran button 60x20
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            "Trending",
                            style: GoogleFonts.ubuntu(
                              color: ColorPalette.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            apiController.loadDataCategories("upcoming");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.carddark,
                            foregroundColor: ColorPalette.white,
                            fixedSize:
                                const Size(120, 20), // Ukuran button 60x20
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            "Upcoming",
                            style: GoogleFonts.ubuntu(
                              color: ColorPalette.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Trending",
                    style: GoogleFonts.ubuntu(
                      color: ColorPalette.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection:
                            Axis.horizontal, // Mengatur scroll horizontal
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        itemCount: apiController.resultctr.length,
                        itemBuilder: (context, index) {
                          final data = apiController.resultctr[index];
                          final image =
                              "${AppConstant.imageurl}${data.posterPath}";
                          final backdrop =
                              "${AppConstant.imageurl}${data.backdropPath}";

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
                              width:
                                  160, // Lebar item agar pas untuk horizontal scroll
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.carddark,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  // Poster film
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Judul dan icon favorite
                                  Expanded(
                                    flex: 1,
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
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    "Top Rated",
                    style: GoogleFonts.ubuntu(
                      color: ColorPalette.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection:
                            Axis.horizontal, // Mengatur scroll horizontal
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: apiController.resultctrtop.length,
                        itemBuilder: (context, index) {
                          final data = apiController.resultctrtop[index];
                          final image =
                              "${AppConstant.imageurl}${data.posterPath}";
                          final backdrop =
                              "${AppConstant.imageurl}${data.backdropPath}";

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
                              width:
                                  160, // Lebar item agar pas untuk horizontal scroll
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.carddark,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  // Poster film
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Judul dan icon favorite
                                  Expanded(
                                    flex: 1,
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
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
    });
  }
}
