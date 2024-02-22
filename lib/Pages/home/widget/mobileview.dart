import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteController.dart';
import 'package:sqflite_favorite/Pages/home/homePageController.dart';
import 'package:sqflite_favorite/api/movie_api.dart';
import 'package:sqflite_favorite/material/color.dart';
import 'package:sqflite_favorite/model/appConstant.dart';
import 'package:sqflite_favorite/model/movie_model.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
                'No Internet Connection , Please Connec                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        t to Internet',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: ColorPalette.secondary),
              ),
            ],
          ),
        );
      }
      return apiController.resultctr.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 45, bottom: 110),
              itemCount: apiController.resultctr.length,
              itemBuilder: (context, index) {
                final data = apiController.resultctr[index];
                final image = "${AppConstant.imageurl}${data.posterPath}";
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorPalette.carddark,
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          foregroundDecoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  data.overview,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          movieController.tapLike(
                                            Movie(
                                                id: data.id,
                                                title: data.title,
                                                image: image),
                                          );
                                        },
                                        icon: Icon(
                                          movieController
                                                  .checkFavorite(data.id)
                                                  .value
                                              ? Icons.favorite
                                              : Icons.favorite_outline_rounded,
                                          size: 20,
                                          color: ColorPalette.main,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
