class Movie {
  int id;
  String title;
  String image;
  String? overview;
  DateTime? release;

  // Constructor
  Movie({
    required this.id,
    required this.title,
    required this.image,
    this.overview,
    this.release,
  });

  // Constructor from Map
  Movie.fromMap({required Map<String, dynamic> map})
      : id = map["id"],
        title = map["title"] ?? "",
        image = map["image"] ?? "",
        overview = map["overview"] ?? "",
        release = map["release_date"] != null
            ? DateTime.tryParse(map["release_date"])
            : null;

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "overview": overview,
      // Format DateTime to String (YYYY-MM-DD) if not null
      "release_date": release?.toIso8601String().split('T').first,
    };
  }
}
