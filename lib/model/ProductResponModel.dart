import 'dart:convert';

MovieResponseModel movieResponseModelFromJson(String str) =>
    MovieResponseModel.fromJson(json.decode(str));

class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class MovieModel {
  final String backdropPath;
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final double popularity;
  final DateTime releaseDate;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

 factory MovieModel.fromJson(Map<String, dynamic> json) {
  return MovieModel(
    backdropPath: json["backdrop_path"] ?? "", // Handle null case
    id: json["id"] ?? 0, // Handle null case
    title: json["title"] ?? "", // Handle null case
    originalTitle: json["original_title"] ?? "", // Handle null case
    overview: json["overview"] ?? "", // Handle null case
    posterPath: json["poster_path"] ?? "", // Handle null case
    popularity: json["popularity"]?.toDouble() ?? 0.0, // Handle null case
    releaseDate: json["release_date"] != null
        ? DateTime.parse(json["release_date"])
        : DateTime.now(), // Provide default value
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0, // Handle null case
    voteCount: json["vote_count"] ?? 0, // Handle null case
  );
}

}


