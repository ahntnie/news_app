import 'package:flutter/material.dart';
import 'package:news_app/Presenter/NewsPresenter.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/View/CategoryNewView.dart';

import '../Model/News.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.string_news});
  final string_news;
  @override
  State<SearchView> createState() => _SearchViewState();
}

List<News> lstSearchNews = List.filled(
    0, News(title: "", description: "", img: "", urlHtml: "", category: ""),
    growable: true);

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() {
    NewsPresenter.searchNews(widget.string_news).then((value) {
      setState(() {
        lstSearchNews = NewsRepository.lstSearchNews;
        print(lstSearchNews.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.string_news);
    load();
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
              child: const Text("Tìm kiếm")),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              children:
                  lstSearchNews.map((e) => newsCard(context, e)).toList()),
        ),
      ),
    );
  }
}
