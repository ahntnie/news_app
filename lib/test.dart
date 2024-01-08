import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class RssReader extends StatefulWidget {
  @override
  _RssReaderState createState() => _RssReaderState();
}

class _RssReaderState extends State<RssReader> {
  String rssUrl =
      'https://vnexpress.net/man-city-thang-lon-o-vong-ba-cup-fa-4698063.html'; // URL của file RSS
  String rssContent = '';

  void fetchRssContent() async {
    final response = await http.get(Uri.parse(rssUrl));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      for (var item in items) {
        final title = item.findElements('title').single.children;
        final link = item.findElements('link').single.children;

        // In ra màn hình console
        print('Title: $title');
        print('Link: $link');

        // Thực hiện chuyển đến file con tại link
        // Code tại đây để chuyển đến file con
      }
    } else {
      print('Failed to fetch RSS content');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSS Reader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: fetchRssContent,
          child: Text('Fetch RSS'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RssReader(),
  ));
}
