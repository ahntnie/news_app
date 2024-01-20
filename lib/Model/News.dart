class News {
  String category;
  String title;
  String description;
  String img;
  String urlHtml;
  News({
    required this.title,
    required this.description,
    required this.img,
    required this.urlHtml,
    required this.category,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      img: json['img'],
      urlHtml: json['urlHtml'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'img': img,
      'urlHtml': urlHtml,
      'category': category,
    };
  }
}
