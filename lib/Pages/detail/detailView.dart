import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_favorite/material/color.dart';
import 'package:sqflite_favorite/model/movie_model.dart';
import 'package:translator/translator.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments
    final Movie movie = Get.arguments;

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    print(movie.release);

    final translator = GoogleTranslator();

    // Variabel untuk menyimpan overview dalam bahasa Indonesia
    String translatedOverview = '';

    // Menerjemahkan overview ke bahasa Indonesia
    translator.translate(movie.overview ?? '', to: 'id').then((value) {
      translatedOverview = value.text;
    });

    return Scaffold(
      backgroundColor: ColorPalette.card,
      appBar: AppBar(
        backgroundColor: ColorPalette.card,
        title: Text(
          movie.title,
          style: GoogleFonts.ubuntu(color: ColorPalette.white),
        ), // Menampilkan judul film
        iconTheme: IconThemeData(color: ColorPalette.white), // Icon warna hitam
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.image,
                width: widthScreen * 1,
                height: heightScreen * 0.55,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    movie.title,
                    style: GoogleFonts.ubuntu(
                      color: ColorPalette.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "|",
                    style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      color: ColorPalette.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    movie.release != null
                        ? DateFormat('d MMMM yyyy').format(movie.release!)
                        : 'Unknown', // Tampilkan 'Unknown' jika tanggal null

                    style: GoogleFonts.ubuntu(
                      color: ColorPalette.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<String>(
              future: translator
                  .translate(movie.overview ?? '', to: 'id')
                  .then((value) => value.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: ColorPalette.white,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    snapshot.data ?? 'Tidak Ada Ringkasan Tersedia',
                    style: GoogleFonts.ubuntu(
                      color: ColorPalette.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
