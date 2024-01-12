import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/News.dart';
import 'package:news_app/View/CategoryNewView.dart';
import 'package:news_app/View/CategoryView.dart';

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({
    super.key,
    required this.news,
  });
  final News news;
  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  final cmt = TextEditingController();
  String gmtt = "";
  List<String> descriptions = [];
  List<String> contents = [];
  List<String> imageUrls = [];
  List<String> test = [];
  List<String> test1 = [];
  bool flag = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String url =
      'https://vnexpress.net/chinh-phu-doc-thuc-van-hanh-metro-nhon-ga-ha-noi-va-ben-thanh-suoi-tien-4698264.html';

  Future<void> fetchHtmlContent() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String htmlContent = response.body;
      print(htmlContent); // In ra đoạn mã HTML
    } else {
      print('Lỗi: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    try {
      if (flag) {
        final response = await http.get(Uri.parse(widget.news.urlHtml));
        final document = parse(response.body);

        // final gmt = parse(response.headers);
        gmtt = response.headers['date'].toString();
        final fullClass = document.querySelectorAll('.fck_detail');
        // print(fullClass.length);
        fullClass.forEach((element) {
          final imageElement = document.querySelectorAll('.fig-picture');
          imageElement.forEach((e) {
            final img = e.outerHtml
                .toString()
                .substring(
                  e.outerHtml.toString().lastIndexOf("srcset=") + 8,
                  e.outerHtml.toString().lastIndexOf("1x"),
                )
                .replaceAll("amp;", '');

            imageUrls.add(img.trim());
          });
        });

        //print(fullClass[0].toString().split('div class="fig-picture"'));

        setState(() {
          flag = false;
          contents = fullClass.map((e) => e.innerHtml).toList();

          test = contents[0].split('<figure data-size="true"');

          test.forEach((txt) {
            test1 = test1 + txt.split("</picture></div>");
          });
          print(test1.length);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    int count1 = 0;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
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
                          color: Color.fromARGB(255, 207, 91, 80),
                          fontSize: 23),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(gmtt),
                ],
              ),
              Text(
                widget.news.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(
                height: 10,
              ),
              Column(
                children: test1.map((e) {
                  int index = test1.length > count ? count++ : test1.length - 1;
                  return index.isEven
                      ? Html(data: test1[index])
                      : Image.network(imageUrls[imageUrls.length > count1
                          ? count1++
                          : imageUrls.length - 1]);
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    "Bình luận",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                  ),
                ],
              ),
              Container(
                // margin: const EdgeInsets.only(top: 30),

                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                    maxLines: null,
                    controller: cmt,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: 'Bình luận của bạn...',
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.send)))),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  width: 350,
                  constraints: const BoxConstraints(
                    minHeight: 100.0,
                    maxHeight: 1000.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 80,
                        decoration: const BoxDecoration(),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.thumb_down)),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Trả lời",
                        style: TextStyle(color: Colors.blue.shade400),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
