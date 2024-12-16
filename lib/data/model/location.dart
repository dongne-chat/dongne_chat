class Location {
  String title;
  String link;
  String category;
  String roadAddress;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.roadAddress,
  });

  Location.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          link: map['link'],
          category: map['category'],
          roadAddress: map['roadAddress'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'category': category,
      'roadAddress': roadAddress,
    };
  }
}
