import 'package:rss_dart/dart_rss.dart';
import 'package:http/http.dart' as http;

import '../Model/News.dart';

class NewsRepository {
  static List<News> lstNews = List.filled(
      0, News(title: "", content: "", img: "", link: ""),
      growable: true);
  static List<News> lstNews_ThoiSu = List.filled(
      0, News(title: "", content: "", img: "", link: ""),
      growable: true);
  static List<News> lstNews_TheThao = List.filled(
      0, News(title: "", content: "", img: "", link: ""),
      growable: true);
  static List<News> lstNews_GiaoDuc = List.filled(
      0, News(title: "", content: "", img: "", link: ""),
      growable: true);
  static List<News> lstNews_NgheThuat = List.filled(
      0, News(title: "", content: "", img: "", link: ""),
      growable: true);
  static Future<void> getNews() async {
    try {
      final clientNews = http.Client();
      final client_GiaoDuc = http.Client();
      final client_ThoiSu = http.Client();
      final client_TheThao = http.Client();
      final client_NgheThuat = http.Client();
      String img;
      String desc;
      String title;
      String link;
      clientNews
          .get(
        Uri.parse(
          'https://vnexpress.net/rss/tin-moi-nhat.rss',
        ),
      )
          .then((response) {
        return response.body;
      }).then((bodyString) {
        int count = 6;
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
            link = channel.items[index].link.toString();
            print("tin mới");
            var news = News(title: title, img: img, content: desc, link: link);
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
      }).then((bodyString) {
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
            link = channel.items[index].link.toString();
            print("Thời sự");
            var news = News(title: title, img: img, content: desc, link: link);
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
      }).then((bodyString) {
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
            link = channel.items[index].link.toString();
            print("Thể thao");
            var news = News(title: title, img: img, content: desc, link: link);
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
      }).then((bodyString) {
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
            link = channel.items[index].link.toString();
            print("giáo dục");
            var news = News(title: title, img: img, content: desc, link: link);
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
      }).then((bodyString) {
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
            link = channel.items[index].link.toString();
            print("nghệ thuật");
            var news = News(title: title, img: img, content: desc, link: link);
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
    String link;
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/thoi-su.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) {
      //print("lấy thời sự");
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
          link = channel.items[index].link.toString();
          print(title);
          var news = News(title: title, img: img, content: desc, link: link);
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
    String link;
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/the-thao.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) {
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
          link = channel.items[index].link.toString();
          print("Thể thao");
          var news = News(title: title, img: img, content: desc, link: link);
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
    String link;
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giao-duc.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) {
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
          link = channel.items[index].link.toString();
          print("Giáo dục");
          var news = News(title: title, img: img, content: desc, link: link);
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
    String link;
    client
        .get(
      Uri.parse(
        'https://vnexpress.net/rss/giai-tri.rss',
      ),
    )
        .then((response) {
      return response.body;
    }).then((bodyString) {
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
          link = channel.items[index].link.toString();
          print("Nghệ thuật");
          var news = News(title: title, img: img, content: desc, link: link);
          lstNews_NgheThuat.add(news);
        }
      }
    });
  }
}
