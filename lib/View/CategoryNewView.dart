import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/News.dart';
import '../Presenter/NewsPresenter.dart';
import '../Repository/NewsRepository.dart';
import 'CategoryDetailView.dart';
import 'CategoryView.dart';
import 'DrawerView.dart';
import 'NavigationBarView.dart';

class CategoryNewView extends StatefulWidget {
  const CategoryNewView({super.key, required this.news});
  final News news;
  @override
  State<CategoryNewView> createState() => _CategoryNewViewState();
}

class _CategoryNewViewState extends State<CategoryNewView> {
  Future<void> saveViewedNews(List<News> viewedNews) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> viewedNewsJsonList =
        viewedNews.map((news) => jsonEncode(news.toJson())).toList();
    await prefs.setStringList('viewedNews', viewedNewsJsonList);
  }

  Future<List<News>> loadViewedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> viewedNewsJsonList = prefs.getStringList('viewedNews') ?? [];
    List<News> viewedNews = viewedNewsJsonList
        .map((json) => News.fromJson(jsonDecode(json)))
        .toList();
    return viewedNews;
  }

  List<News> viewedNews = [];

  List<News> lstNews = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);
  final List<News> _lstNews = List.filled(
      0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
      growable: true);

  @override
  void initState() {
    super.initState();
    Load();
    loadViewedNews().then((newsList) {
      setState(() {
        viewedNews = newsList;
      });
    });
  }

  String name = "";
  Load() async {
    if (name != widget.news.category) {
      print("new");
      name = widget.news.category;
      lstNews = List.filled(0,
          News(title: "", description: "", img: "", urlHtml: "", category: ""),
          growable: true);
    }
    NewsPresenter.getNews().then((value) {
      setState(() {
        lstNews_New = NewsRepository.lstNews;
      });
    });
    if (widget.news.category == "Thời sự") {
      NewsPresenter.getNews_ThoiSu().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_ThoiSu;
        });
      });
    } else if (widget.news.category == "Thể thao") {
      NewsPresenter.getNews_TheThao().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_TheThao;
        });
      });
    } else if (widget.news.category == "Giáo dục") {
      NewsPresenter.getNews_GiaoDuc().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_GiaoDuc;
        });
      });
    } else {
      NewsPresenter.getNews_NgheThuat().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_NgheThuat;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (lstNews.length < 9) {
      Load();
      return Center(
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "assets/image/iconNews.jpg",
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.grey,
                size: 50,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width / 2.2,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("VLTT "),
                Text(
                  "Tin tức",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: const BottomNav(
          idx: 0,
        ),
        drawer: const DrawerView(),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CategoryView(name: widget.news.category)));
                  },
                  child: Text(
                    widget.news.category,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 250, 19, 2), fontSize: 23),
                  ),
                ),
                const Text("/", style: TextStyle(fontSize: 23)),
                InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryNewView(
                              news: widget.news,
                            )));
                  },
                  child: const Text(
                    " Tin mới nhất",
                    style: TextStyle(
                        color: Color.fromARGB(255, 207, 91, 80), fontSize: 23),
                  ),
                ),
              ],
            ),
            Column(
              children: lstNews.map((e) => newsCard(context, e)).toList(),
            ),
            const Divider(),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 20,
                        ),
                        Text(
                          "Điện thoại: ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          "0938523503",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          "Địa chỉ: ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Expanded(
                            child: Text(
                          "65 Huỳnh Thúc Kháng, Quận 1, TP Hồ Chí Minh",
                          style: TextStyle(fontSize: 10),
                        ))
                      ],
                    ),
                    Text(
                      "Tổng biên tập: Lê Hữu Thành",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Phó tổng biên tập: Bùi Thanh Viên",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Phó tổng biên tập: Bạch Anh Tiến",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Phó tổng biên tập: Phạm Ngọc Liêm",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Cấm sao chép với mọi hình thức nếu không có sự chấp thuận bằng văn bản",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    }
  }
}

ListTile newsCard(BuildContext context, News news) {
  return ListTile(
    onTap: () {
      if (!viewedNews.contains(news)) {
        viewedNews.add(news);
        saveViewedNews(viewedNews);
        print("Đã lưu");
      } else {
        print("Trùng");
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoryDetailView(news: news)));
    },
    title: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                news.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    news.description,
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
