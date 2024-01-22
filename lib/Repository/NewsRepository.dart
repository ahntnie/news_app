import 'dart:convert';

import 'package:rss_dart/dart_rss.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/News.dart';

class NewsRepository {
  static List<News> lstNews = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstNews_ThoiSu = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstNews_TheThao = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstNews_GiaoDuc = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstNews_NgheThuat = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstSearchNews = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static List<News> lstViewedNews = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  static Future<void> getNews() async {
    try {
      final clientNews = http.Client();
      String img;
      String desc;
      String title;
      String urlHtml;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> viewedNewsJsonList = prefs.getStringList('viewedNews') ?? [];
      lstViewedNews = viewedNewsJsonList
          .map((json) => News.fromJson(jsonDecode(json)))
          .toList();
      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/tin-moi-nhat.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) async {
        int count = 11;
        if (lstNews.isEmpty) {
          for (int index = 1; index < count; index++) {
            final channel = RssFeed.parse(bodyString);
            if (!channel.items[index].description
                .toString()
                .contains("img src=")) {
              count++;
              continue;
            }
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();

            var news = News(
                title: title,
                img: img,
                description: desc,
                urlHtml: urlHtml,
                category: "Tin mới");
            lstNews.add(news);
          }
        }
      });
      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/thoi-su.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) async {
        int count = 2;
        if (lstNews_ThoiSu.isEmpty) {
          for (int index = 1; index < count; index++) {
            final channel = RssFeed.parse(bodyString);
            if (!channel.items[index].description
                .toString()
                .contains("img src=")) {
              count++;
              print("continue");
              continue;
            }
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();

            var news = News(
                title: title,
                img: img,
                description: desc,
                urlHtml: urlHtml,
                category: "Thời sự");

            lstNews_ThoiSu.add(news);
          }
        }
      });
      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/the-thao.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) async {
        int count = 2;
        if (lstNews_TheThao.isEmpty) {
          for (int index = 1; index < count; index++) {
            final channel = RssFeed.parse(bodyString);
            if (!channel.items[index].description
                .toString()
                .contains("img src=")) {
              count++;
              print("continue");

              continue;
            }
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            var news = News(
                title: title,
                img: img,
                description: desc,
                urlHtml: urlHtml,
                category: "Thể thao");
            lstNews_TheThao.add(news);
          }
        }
      });

      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/giao-duc.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) async {
        int count = 2;
        if (lstNews_GiaoDuc.isEmpty) {
          for (int index = 1; index < count; index++) {
            final channel = RssFeed.parse(bodyString);
            if (!channel.items[index].description
                .toString()
                .contains("img src=")) {
              count++;
              print("continue");

              continue;
            }
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            var news = News(
                title: title,
                img: img,
                description: desc,
                urlHtml: urlHtml,
                category: "Giáo dục");
            lstNews_GiaoDuc.add(news);
          }
        }
      });

      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/giai-tri.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) async {
        int count = 2;
        if (lstNews_NgheThuat.isEmpty) {
          for (int index = 1; index < count; index++) {
            final channel = RssFeed.parse(bodyString);
            if (!channel.items[index].description
                .toString()
                .contains("img src=")) {
              count++;
              print("continue");
              continue;
            }
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            var news = News(
                title: title,
                img: img,
                description: desc,
                urlHtml: urlHtml,
                category: "Nghệ thuật");
            lstNews_NgheThuat.add(news);
          }
        }
      });
    } catch (Exception) {
      print("Lỗi");
    }
  }

  static Future<void> getNews_ThoiSu() async {
    final client = http.Client();
    String img;
    String desc;
    String title;

    String urlHtml;

    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/thoi-su.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      int count = 11;
      if (lstNews_ThoiSu.length < 2) {
        lstNews_ThoiSu.removeAt(0);
        for (int index = 1; index < count; index++) {
          final channel = RssFeed.parse(bodyString);
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            count++;
            print("continue");
            continue;
          }
          img = channel.items[index].description.toString().substring(
              channel.items[index].description
                      .toString()
                      .lastIndexOf('img src=') +
                  9,
              channel.items[index].description.toString().lastIndexOf('>') -
                  11);
          desc = channel.items[index].description.toString().substring(
              channel.items[index].description.toString().lastIndexOf('>') + 1);
          title = channel.items[index].title.toString();

          urlHtml = channel.items[index].link.toString();
          var news = News(
              title: title,
              img: img,
              description: desc,
              urlHtml: urlHtml,
              category: "Thời sự");

          lstNews_ThoiSu.add(news);
        }
      }
    });
  }

  ///Tìm kiếm
  static Future<void> searchNews(String stringNews) async {
    final client = http.Client();
    String img;
    String desc;
    String title;
    String urlHtml;

    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/tin-moi-nhat.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      final channel = RssFeed.parse(bodyString);
      if (lstSearchNews.isEmpty) {
        for (int index = 1; index <= channel.items.length; index++) {
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            continue;
          }
          if (channel.items[index].title
                  .toString()
                  .toLowerCase()
                  .contains(stringNews.toString().toLowerCase()) ||
              channel.items[index].description
                  .toString()
                  .toLowerCase()
                  .contains(stringNews.toString().toLowerCase())) {
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            if (lstSearchNews.length < 5) {
              lstSearchNews.add(News(
                  title: title,
                  description: desc,
                  img: img,
                  urlHtml: urlHtml,
                  category: "Tin mới"));
            }
          }
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy mới nhất");
    });
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/thoi-su.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      final channel = RssFeed.parse(bodyString);
      if (lstSearchNews.isEmpty) {
        for (int index = 1; index <= channel.items.length; index++) {
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            continue;
          }
          if (channel.items[index].title
              .toString()
              .toLowerCase()
              .contains(stringNews.toString().toLowerCase())) {
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            lstSearchNews.add(News(
                title: title,
                description: desc,
                img: img,
                urlHtml: urlHtml,
                category: "Thời sự"));
          }
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy thời sự");
    });
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/the-thao.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      final channel = RssFeed.parse(bodyString);
      if (lstSearchNews.isEmpty) {
        for (int index = 1; index <= channel.items.length; index++) {
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            continue;
          }
          if (channel.items[index].title
              .toString()
              .toLowerCase()
              .contains(stringNews.toString().toLowerCase())) {
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            lstSearchNews.add(News(
                title: title,
                description: desc,
                img: img,
                urlHtml: urlHtml,
                category: "Thể thao"));
          }
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy thể thao");
    });
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giao-duc.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      final channel = RssFeed.parse(bodyString);
      if (lstSearchNews.isEmpty) {
        for (int index = 1; index <= channel.items.length; index++) {
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            continue;
          }
          if (channel.items[index].title
              .toString()
              .toLowerCase()
              .contains(stringNews.toString().toLowerCase())) {
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            lstSearchNews.add(News(
                title: title,
                description: desc,
                img: img,
                urlHtml: urlHtml,
                category: "Giáo dục"));
          }
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy giáo dục");
    });
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giai-tri.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      final channel = RssFeed.parse(bodyString);
      if (lstSearchNews.isEmpty) {
        for (int index = 1; index <= channel.items.length; index++) {
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            continue;
          }
          if (channel.items[index].title
              .toString()
              .toLowerCase()
              .contains(stringNews.toString().toLowerCase())) {
            img = channel.items[index].description.toString().substring(
                channel.items[index].description
                        .toString()
                        .lastIndexOf('img src=') +
                    9,
                channel.items[index].description.toString().lastIndexOf('>') -
                    11);
            desc = channel.items[index].description.toString().substring(
                channel.items[index].description.toString().lastIndexOf('>') +
                    1);
            title = channel.items[index].title.toString();

            urlHtml = channel.items[index].link.toString();
            lstSearchNews.add(News(
                title: title,
                description: desc,
                img: img,
                urlHtml: urlHtml,
                category: "Nghệ thuật"));
          }
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy nghệ thuật");
    });
  }

  static Future<void> getNews_TheThao() async {
    //print("lấy thể thao");
    final client = http.Client();
    String img;
    String desc;
    String title;

    String urlHtml;

    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/the-thao.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      int count = 11;
      if (lstNews_TheThao.length < 2) {
        lstNews_TheThao.removeAt(0);
        for (int index = 1; index < count; index++) {
          final channel = RssFeed.parse(bodyString);
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            count++;
            continue;
          }
          img = channel.items[index].description.toString().substring(
              channel.items[index].description
                      .toString()
                      .lastIndexOf('img src=') +
                  9,
              channel.items[index].description.toString().lastIndexOf('>') -
                  11);
          desc = channel.items[index].description.toString().substring(
              channel.items[index].description.toString().lastIndexOf('>') + 1);
          title = channel.items[index].title.toString();
          urlHtml = channel.items[index].link.toString();
          var news = News(
              title: title,
              img: img,
              description: desc,
              urlHtml: urlHtml,
              category: "Thể thao");

          lstNews_TheThao.add(news);
        }
      }
    }).catchError((onError) {
      print("Lỗi lấy thể thao");
    });
  }

  static Future<void> getNews_GiaoDuc() async {
    final client = http.Client();
    String img;
    String desc;
    String title;
    String urlHtml;

    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giao-duc.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      int count = 11;
      if (lstNews_GiaoDuc.length < 2) {
        lstNews_GiaoDuc.removeAt(0);
        for (int index = 1; index < count; index++) {
          final channel = RssFeed.parse(bodyString);
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            count++;
            continue;
          }
          img = channel.items[index].description.toString().substring(
              channel.items[index].description
                      .toString()
                      .lastIndexOf('img src=') +
                  9,
              channel.items[index].description.toString().lastIndexOf('>') -
                  11);
          desc = channel.items[index].description.toString().substring(
              channel.items[index].description.toString().lastIndexOf('>') + 1);
          title = channel.items[index].title.toString();

          urlHtml = channel.items[index].link.toString();
          var news = News(
              title: title,
              img: img,
              description: desc,
              urlHtml: urlHtml,
              category: "Giáo dục");
          lstNews_GiaoDuc.add(news);
        }
      }
    });
  }

  static Future<void> getNews_NgheThuat() async {
    final client = http.Client();
    String img;
    String desc;
    String title;

    String urlHtml;

    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giai-tri.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) async {
      int count = 11;
      if (lstNews_NgheThuat.length < 2) {
        lstNews_NgheThuat.removeAt(0);
        for (int index = 1; index < count; index++) {
          final channel = RssFeed.parse(bodyString);
          if (!channel.items[index].description
              .toString()
              .contains("img src=")) {
            count++;
            continue;
          }
          img = channel.items[index].description.toString().substring(
              channel.items[index].description
                      .toString()
                      .lastIndexOf('img src=') +
                  9,
              channel.items[index].description.toString().lastIndexOf('>') -
                  11);
          desc = channel.items[index].description.toString().substring(
              channel.items[index].description.toString().lastIndexOf('>') + 1);
          title = channel.items[index].title.toString();

          urlHtml = channel.items[index].link.toString();
          var news = News(
              title: title,
              img: img,
              description: desc,
              urlHtml: urlHtml,
              category: "Nghệ thuật");

          lstNews_NgheThuat.add(news);
        }
      }
    });
  }
}
