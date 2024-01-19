import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Model/News.dart';
import 'package:news_app/Presenter/NewsPresenter.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/View/CategoryDetailView.dart';
import 'package:news_app/View/CategoryView.dart';
import 'package:news_app/View/DrawerView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../Model/Category.dart';
import 'NavigationBarView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

var video;
final list = [
  'assets/image/introdutory.png',
  'assets/image/introdutory.png',
  'assets/image/introdutory.png',
  'assets/image/introdutory.png'
];
final urlImages = [
  'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
  'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
];

final categories = [
  CategoryModel(categoryName: "Thể thao", image: "assets/image/thethao.jpg"),
  CategoryModel(categoryName: "Thời sự", image: "assets/image/thoisu.jpg"),
  CategoryModel(categoryName: "Giáo dục", image: "assets/image/giaoduc.jpg"),
  CategoryModel(
      categoryName: "Nghệ thuật", image: "assets/image/nghethuat.jpg"),
];
final SizerUtil sizerUtil = SizerUtil();
bool onTap_ThoiSu = false;
bool onTap_TheThao = false;
bool onTap_NgheThuat = false;
bool onTap_GiaoDuc = false;

//const baseSize = 16;
const baseScreenSize = 375;

double size(BuildContext context, int baseSize) {
  final screenSize = MediaQuery.of(context).size.height;
  return baseSize * (screenSize / baseScreenSize);
}

// Future<void> PhatVideo() async {
//   final ref = FirebaseStorage.instance.ref('vidoe đồ án .mp4');
//   final url = await ref.getDownloadURL();
//   final controller = VideoPlayerController.networkUrl(Uri.parse(url));
//   controller.initialize();
//   controller.play();
//   video = Center(
//     child: AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: VideoPlayer(controller),
//     ),
//   );
// }

class _HomeViewState extends State<HomeView> {
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
  // @override
  // void initState() {
  //   PhatVideo();
  //   super.initState();
  // }
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
  static List<News> lstViewedNews = List.filled(
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

  Load() async {
    if ((lstNews.isEmpty ||
        lstNews_GiaoDuc.isEmpty ||
        lstNews_NgheThuat.isEmpty ||
        lstNews_TheThao.isEmpty ||
        lstNews_ThoiSu.isEmpty)) {
      NewsPresenter.getNews().then((value) {
        setState(() {
          lstNews = NewsRepository.lstNews;
          lstNews_ThoiSu = NewsRepository.lstNews_ThoiSu;
          lstNews_TheThao = NewsRepository.lstNews_TheThao;
          lstNews_GiaoDuc = NewsRepository.lstNews_GiaoDuc;
          lstNews_NgheThuat = NewsRepository.lstNews_NgheThuat;
          lstViewedNews = NewsRepository.lstViewedNews;
        });
      });
    }
  }

  double FontSize(double value, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Tính toán kích thước font chữ dựa trên kích thước màn hình và độ phân giải
    final fontSize = screenWidth * screenHeight * pixelRatio * value * 0.001;

    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    Load();
    if (!(lstNews.isEmpty ||
        lstNews_GiaoDuc.isEmpty ||
        lstNews_NgheThuat.isEmpty ||
        lstNews_TheThao.isEmpty ||
        lstNews_ThoiSu.isEmpty)) {
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
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  height: 70,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          image: categories[index].image,
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: lstNews.length,
                    itemBuilder: (context, index, realIndex) {
                      final news = lstNews[index].img;

                      return buildImage(news, index, lstNews[index], context);
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        titleCategory("Thời sự"),
                        newsCard(context, lstNews_ThoiSu[0]),
                        titleCategory("Thể thao"),
                        newsCard(context, lstNews_TheThao[0]),
                        titleCategory("Giáo dục"),
                        newsCard(context, lstNews_GiaoDuc[0]),
                        titleCategory("Nghệ thuật"),
                        newsCard(context, lstNews_NgheThuat[0]),
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
        body: Center(
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
        ),
        drawer: const DrawerView(),
        bottomNavigationBar: const BottomNav(idx: 0),
      ));
    }
  }

  Padding newsCard(BuildContext context, News news) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            viewedNews.add(news);
            saveViewedNews(viewedNews);
            print("đã lưu");
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryDetailView(news: news)));
        },
        child: Container(
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
      ),
    );
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryView(
                      name: name,
                    )));
          },
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

  int activeIndex = 0;

  final controller = CarouselController();

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: Colors.black),
        activeIndex: activeIndex,
        count: lstNews.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(
        String assetImage, int index, News news, BuildContext context) =>
    InkWell(
      onTap: () {
        viewedNews.add(news);
        saveViewedNews(viewedNews);
        print("đã lưu");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryDetailView(
                  news: news,
                )));
      },
      child: Stack(children: [
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
  const CategoryTile({super.key, this.categoryName, this.image});
  final image, categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryView(
                  name: categoryName,
                )));
      },
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
