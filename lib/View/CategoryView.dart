import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/View/DrawerView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Model/News.dart';
import '../Presenter/NewsPresenter.dart';
import 'CategoryDetailView.dart';
import 'NavigationBarView.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.name});
  final String name;
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

List<News> lstNews_New = List.filled(
    0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
    growable: true);

List<News> lstNews = List.filled(
    0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
    growable: true);
bool shorten = false;

class _CategoryViewState extends State<CategoryView> {
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
    if (name != widget.name) {
      print("new");
      name = widget.name;

      lstNews = List.filled(0,
          News(title: "", description: "", img: "", urlHtml: "", category: ""),
          growable: true);
    }
    NewsPresenter.getNews().then((value) {
      setState(() {
        lstNews_New = NewsRepository.lstNews;
      });
    });
    if (widget.name == "Tin mới") {
      setState(() {
        lstNews = NewsRepository.lstNews;
      });
    } else if (widget.name == "Thời sự") {
      NewsPresenter.getNews_ThoiSu().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_ThoiSu;
        });
      });
    } else if (widget.name == "Thể thao") {
      NewsPresenter.getNews_TheThao().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews_TheThao;
        });
      });
    } else if (widget.name == "Giáo dục") {
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
    print(lstNews.length);
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
      return SafeArea(
        child: Scaffold(
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
            drawer: const DrawerView(),
            body: SingleChildScrollView(
              child: Column(children: [
                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: lstNews_New.length,
                    itemBuilder: (context, index, realIndex) {
                      final news = lstNews_New[index].img;
                      return buildImage(
                          news, index, lstNews_New[index], context);
                    },
                    options: CarouselOptions(
                        disableCenter: true,
                        height: MediaQuery.of(context).size.height / 4,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index))),
                const SizedBox(height: 12),
                buildIndicator(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(color: Colors.red),
                          ),
                          Row(
                            children: [
                              CupertinoSwitch(
                                  value: shorten,
                                  onChanged: (bool value) {
                                    setState(() {
                                      shorten = !shorten;
                                    });
                                  }),
                              const Text(
                                "Rút gọn",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          )
                        ])),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        shorten
                            ? newsCard(context, lstNews[0])
                            : Column(
                                children: lstNews
                                    .map((e) => newsCard(context, e))
                                    .toList())
                      ],
                    )),
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
            bottomNavigationBar: const BottomNav(
              idx: 0,
            )),
      );
    }
  }
}

int activeIndex = 0;
final controller = CarouselController();
void animateToSlide(int index) => controller.animateToPage(index);
Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect:
          const ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.black),
      activeIndex: activeIndex,
      count: lstNews_New.length,
    );

Widget buildImage(
        String assetImage, int index, News news, BuildContext context) =>
    ListTile(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryDetailView(
                  news: news,
                )));
      },
      title: Stack(children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(assetImage, fit: BoxFit.fill, scale: 10)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(
                news.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ]),
    );

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                  child: Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}

Row titleCategory(String name) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          name,
          style: const TextStyle(color: Colors.red),
        ),
      ),
      const Expanded(
        child: Divider(
          color: Colors.black,
          indent: 10,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: const Text(
          "Xem tất cả",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontSize: 10,
          ),
        ),
      )
    ],
  );
}

ListTile newsCard(BuildContext context, News news) {
  return ListTile(
    onTap: () {
      viewedNews.add(news);
      saveViewedNews(viewedNews);
      print("đã lưu");
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
