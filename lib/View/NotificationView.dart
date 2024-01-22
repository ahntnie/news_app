import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/Comment.dart';
import 'package:news_app/Model/News.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:news_app/View/CategoryDetailView.dart';
import 'package:news_app/View/DrawerView.dart';
import 'package:news_app/View/LoginView.dart';
import 'package:news_app/View/NavigationBarView.dart';
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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

  Future<void> saveNotiCmt(List<Comment> viewedNews) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> viewedCmtJsonList =
        viewedNotiCmt.map((comments) => jsonEncode(comments.toJson())).toList();
    await prefs.setStringList('viewedNotiCmt', viewedCmtJsonList);
  }

  Future<List<Comment>> loadNotiCmt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> viewedCmtJsonList = prefs.getStringList('viewedNotiCmt') ?? [];
    List<Comment> viewedNotiCmt = viewedCmtJsonList
        .map((json) => Comment.fromJson(jsonDecode(json)))
        .toList();
    return viewedNotiCmt;
  }

  final rssUrl = 'https://vnexpress.net/rss/tin-moi-nhat.rss';

  List<News> viewedNews = [];
  List<Comment> viewedNotiCmt = [];
  @override
  void initState() {
    super.initState();
    loadViewedNews().then((newsList) {
      setState(() {
        viewedNews = newsList;
      });
    });
    loadNotiCmt().then((newsComments) {
      setState(() {
        viewedNotiCmt = newsComments;
      });
    });
  }

  Future<RssFeed> _fetchRssFeed() async {
    final response = await http.get(Uri.parse(rssUrl));
    if (response.statusCode == 200) {
      return RssFeed.parse(response.body);
    } else {
      throw Exception('Failed to fetch RSS feed');
    }
  }

  String _getFormattedDateTime(String dateTimeString) {
    final format = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z');
    final dateTime = format.parse(dateTimeString);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width / 2.2,
          height: 40,
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Tin mới nhất'),
                Tab(text: 'Bình luận'),
                Tab(text: 'Tin đã xem'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _TabNotification(),
                  _TabComment(),
                  _TabStoryAgain(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(idx: 1),
    );
  }

  Widget _TabNotification() {
    return FutureBuilder<RssFeed>(
      future: _fetchRssFeed(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rssFeed = snapshot.data!;
          return ListView.builder(
            itemCount: rssFeed.items.length,
            itemBuilder: (context, index) {
              final rssItem = rssFeed.items[index];
              final pubDate = _getFormattedDateTime(rssItem.pubDate ?? '');
              final umllink = rssItem.link ?? '';
              final htmlContent = rssItem.description;
              final tittle1 = rssItem.title;
              var img = "";
              if (rssItem.description.toString().contains("img src=")) {
                img = rssItem.description.toString().substring(
                    rssItem.description.toString().lastIndexOf('img src=') + 9,
                    rssItem.description.toString().lastIndexOf('>') - 11);
              }
              if (img.isNotEmpty) {
                bool isViewed =
                    viewedNews.any((news) => news.urlHtml == umllink);

                News(
                  title: tittle1.toString(),
                  description: htmlContent.toString(),
                  img: img,
                  urlHtml: umllink,
                  category: "Tin mới",
                );
                return GestureDetector(
                  onTap: () async {
                    print(umllink);
                    if (!isViewed) {
                      setState(() {
                        viewedNews.add(News(
                          title: tittle1.toString(),
                          description: htmlContent.toString(),
                          img: img,
                          urlHtml: umllink,
                          category: "Tin mới",
                        ));
                        saveViewedNews(viewedNews);
                      });
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryDetailView(
                          news: News(
                            title: rssItem.title.toString(),
                            description: htmlContent.toString(),
                            img: img,
                            urlHtml: umllink,
                            category: "Tin mới",
                          ),
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rssItem.title ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Html(
                            data: rssItem.description ?? '',
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Thời gian cập nhật: $pubDate',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Text("");
              }
            },
          );
        } else if (snapshot.hasError) {
          Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _TabComment() {
    return SingleChildScrollView(
      child: Column(
        children: [BoxComment()],
      ),
    );

    //}
  }

  Container BoxComment() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      // padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300),
      ),
      width: MediaQuery.of(context).size.width / 0.1,
      height: MediaQuery.of(context).size.height / 7,
      constraints: const BoxConstraints(
        minHeight: 100.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              //height: MediaQuery.of(context).size.height / 8,
              decoration: const BoxDecoration(),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            "assets/image/avt.png",
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 30),
                            child: Text(
                              "Bach Anh Tien đã thích bình luận của bạnbạnbạnbạn",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("hello"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> lstComment = [];
  List<Comment> lstGetCmt = [];

  Widget _TabStoryAgain() {
    void desc = "";
    if (viewedNews.isEmpty) {
      return const Center(
        child: Text('Không có tin đã xem'),
      );
    }
    return ListView.builder(
      itemCount: viewedNews.length,
      itemBuilder: (context, index) {
        final news = viewedNews[viewedNews.length - index - 1];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailView(
                  news: news,
                ),
              ),
            );
          },
          child: SizedBox(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Image.network(news.img),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // ignore: void_checks
                    desc = news.description.toString().substring(
                        news.description.toString().lastIndexOf('>') + 1),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Danh mục: ${news.category}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
