import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_favorite/Pages/favorite/favoriteController.dart';
import 'package:sqflite_favorite/material/color.dart';

class MobileFavorite extends StatelessWidget {
  const MobileFavorite({super.key, required this.favoriteController});

  final FavoriteController favoriteController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Obx(
        () => favoriteController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : favoriteController.favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: ColorPalette.main,
                          size: 72,
                        ),
                        Text(
                          'No Favorite Item',
                          style: TextStyle(
                              color: ColorPalette.secondary,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 45, bottom: 110),
                    itemCount: favoriteController.favorites.length,
                    itemBuilder: (context, index) {
                      final data = favoriteController.favorites[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPalette.carddark,
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Image.file(
                                File(data.image),
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: IconButton(
                                            onPressed: () {
                                              AlertDialog alert = AlertDialog(
                                                backgroundColor:
                                                    ColorPalette.carddark,
                                                // Set background color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Text(
                                                        "Are you sure to remove this product from your favorite list?",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            favoriteController
                                                                .removeFavorite(
                                                                    data);
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                              color:
                                                                  ColorPalette
                                                                      .main,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.favorite_rounded,
                                              size: 20,
                                              color: ColorPalette.main,
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
    );
  }
}
