import 'package:news_app/Repository/NewsRepository.dart';


class NewsPresenter {
  static Future<void> getNews() async {
    return await NewsRepository.getNews();
  }

  static Future<void> getNews_TheThao() async {
    return await NewsRepository.getNews_TheThao();
  }

  static Future<void> getNews_GiaoDuc() async {
    return await NewsRepository.getNews_GiaoDuc();
  }

  static Future<void> getNews_ThoiSu() async {
    return await NewsRepository.getNews_ThoiSu();
  }

  static Future<void> getNews_NgheThuat() async {
    return await NewsRepository.getNews_NgheThuat();
  }

  static Future<void> searchNews(String stringNews) async {
    return await NewsRepository.searchNews(stringNews);
  }
}
