import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:news_app/View/HomeView.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> contents = [];
  List<String> imageUrls = [];
  List<String> test = [];
  List<String> test1 = [];
  List<String> test2 = [];
  String gmtt = "";
  // String desc = "";
  @override
  void initState() {
    super.initState();
    // fetchData();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://vnexpress.net/nhieu-nguoi-ho-tro-phi-cong-su-22-tiep-dat-4698844.html'));
      final document = parse(response.body);

      // final gmt = parse(response.headers);
      gmtt = response.headers['date'].toString();
      //print(gmtt);
      final fullClass = document.querySelectorAll('.fck_detail');
      print(fullClass);
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

      print(fullClass[0].toString().split('div class="fig-picture"'));

      setState(() {
        contents = fullClass.map((e) => e.innerHtml).toList();

        test = contents[0].split('<figure data-size="true"');
        test.forEach((txt) {
          test1 = test1 + txt.split("</picture></div>");
        });
        print(test1.length);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lấy hình ảnh từ HTML',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Hình ảnh từ HTML'),
          ),
          body: ListView.builder(
            itemCount: test1.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: index.isEven
                      ? Html(data: test1[index])
                      : Image.network(imageUrls[imageUrls.length > count
                          ? count++
                          : imageUrls.length - 1]));
            },
          )),
    );
  }
}

void main() {
  runApp(MyApp());
}
