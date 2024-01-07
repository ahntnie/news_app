import 'package:http/http.dart' as http;
import 'package:rss_dart/dart_rss.dart';

void main() {
  final client = http.Client();

  // RSS feed
  client
      .get(
    Uri.parse(
      'https://vnexpress.net/rss/tin-moi-nhat.rss',
    ),
  )
      .then((response) {
    return response.body;
  }).then((bodyString) {
    int index = 4;
    final channel = RssFeed.parse(bodyString);
    String img = channel.items[index].description.toString().substring(
        channel.items[index].description.toString().lastIndexOf('img src=') + 9,
        channel.items[index].description.toString().lastIndexOf('>') - 11);
    String desc = channel.items[index].description.toString().substring(
        channel.items[index].description.toString().lastIndexOf('>') + 1);
    // print(channel.title);
    print("Chưa chỉnh: ${channel.items[index].description.toString()}");

    print(desc);
    print(img);
    return channel;
  });

  // Atom feed
  client
      .get(Uri.parse('https://www.theverge.com/rss/index.xml'))
      .then((response) {
    return response.body;
  }).then((bodyString) {
    final feed = AtomFeed.parse(bodyString);
    //print(feed.title);

    return feed;
  });
}

class ParsedDescription {
  final String link;
  final String imageUrl;
  final String content;

  ParsedDescription(
      {required this.link, required this.imageUrl, required this.content});
}
