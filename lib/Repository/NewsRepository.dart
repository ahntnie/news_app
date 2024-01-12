import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:html/parser.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:http/http.dart' as http;

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
  static Future<void> getNews() async {
    try {
      final clientNews = http.Client();
      String img;
      String desc;
      String title;
      String urlHtml;

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

            print("tin mới");
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
        print("lấy thời sự");
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

            print("Thời sự");
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
        print("lấy THỂ THAO");

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
            print("Thể thao");
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
        print("lấy GIÁO DỤC");
        print("Giáo dục: ${lstNews_GiaoDuc.length}");
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
            print("Giáo dục");
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
        print("lấy NGHỆ THUẬT");

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
            print("Nghệ thuật");
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
          print("Thời sự");
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
          print("Thể thao");
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
          print("Giáo dục");
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
          print(urlHtml);
          print("Nghệ thuật");
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
