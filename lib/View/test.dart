// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser.dart' show parse;

// class Test extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<Test> {
//   List<String> descriptions = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://vnexpress.net/vks-dai-an-viet-a-la-dien-hinh-tham-nhung-co-he-thong-4698050.html'));
//       final document = parse(response.body);
//       final descriptionElements = document.querySelectorAll('.block_thumb_slide_show');
//       setState(() {
//         descriptions = descriptionElements.map((e) => e.innerHtml).toList();
//         print(descriptions.length);
//       });
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Read URL description',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('URL description'),
//         ),
//         body: ListView.builder(
//           itemCount: descriptions.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Html(data: descriptions[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:rss_dart/dart_rss.dart';

class HtmlToString extends StatefulWidget {
  @override
  _HtmlToStringState createState() => _HtmlToStringState();
}

class _HtmlToStringState extends State<HtmlToString> {
  String htmlString = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://vnexpress.net/chinh-phu-doc-thuc-van-hanh-metro-nhon-ga-ha-noi-va-ben-thanh-suoi-tien-4698264.html'));
    if (response.statusCode == 200) {
      final channel = RssFeed.parse(response.body);
      //final document = parser.parse(response.body);
      print(channel.items[0].link.toString());
      // setState(() {
      //   //htmlString = parseHtml(document.body as dom.Node);
      // });
    }
  }

  String parseHtml(dom.Node node) {
    var buffer = StringBuffer();
    if (node.nodeType == dom.Node.ELEMENT_NODE) {
      var element = node as dom.Element;
      if (element.localName == 'img') {
        print(element.toString());
        buffer.write(element.text);
      } else {
        for (var child in element.nodes) {
          buffer.write(parseHtml(child));
        }
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML to String'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(htmlString),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HtmlToString()));
}
