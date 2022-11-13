class News {
  String date;
  List<Story> stories;

  News({
    required this.date,
    required this.stories,
  });

  factory News.fromJSON(Map<String, dynamic> json) => News(
        date: json["date"],
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJSON(x))),
      );
}

class Story {
  String title;
  String url;
  String hint;
  String imageUrl;

  Story({
    required this.title,
    required this.url,
    required this.hint,
    required this.imageUrl,
  });

  factory Story.fromJSON(Map<String, dynamic> json) => Story(
        title: json["title"],
        url: json["url"],
        hint: json["hint"],
        imageUrl: json["image"] ?? json["images"][0],
      );
}
