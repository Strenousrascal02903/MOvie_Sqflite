import 'package:flutter/cupertino.dart';
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
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: ColorPalette.main),
              ),
            ],
          ),
        );
      }
      return apiController.resultctr.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 5.5,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                apiController.loadDataCategories("now_playing");
                              },
                              child: Text("Now Playing"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                apiController.loadDataCategories("popular");
                              },
                              child: Text("Popular"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                apiController.loadDataCategories("top_rated");
                              },
                              child: Text("Top Rated"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                apiController.loadDataCategories("upcoming");
                              },
                              child: Text("Upcoming"),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 13,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.70),
                      padding: const EdgeInsets.only(top: 45, bottom: 110),
                      itemCount: apiController.resultctr.length,
                      itemBuilder: (context, index) {
                        final data = apiController.resultctr[index];
                        final image =
                            "${AppConstant.imageurl}${data.posterPath}";
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.1), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: ColorPalette.background,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: widthScreen * 0.3,
                                    height: heightScreen * 0.14,
                                    foregroundDecoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            data.title,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                                          .checkFavorite(
                                                              data.id)
                                                          .value
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_outline_rounded,
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
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
