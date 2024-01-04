import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/View/Screen/NewsScreen_Detail/widget/drawer.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

final cmt = TextEditingController();

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Thời sự ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 250, 19, 2), fontSize: 23),
                  ),
                ),
                const Text("/", style: TextStyle(fontSize: 23)),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    " Tin mới nhất",
                    style: TextStyle(
                        color: Color.fromARGB(255, 207, 91, 80), fontSize: 23),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Thứ 6, 05/01/2024",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Phó thống đốc: Không chấp nhận giá vàng trong nước chênh cao so với thế giới',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Ông Đào Minh Tú nói không khuyến khích kinh doanh, bảo hộ giá vàng, nhưng cũng không chấp nhận chênh lệch giá trong và ngoài nước tới 20 triệu đồng mỗi lượng.',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  "https://hthaostudio.com/wp-content/uploads/2020/06/Phu-Hung-Land-78-min-1180x760.jpg"),
            ),
            const Text(
              "Ảnh nguồn VNExpress.net",
              textAlign: TextAlign.center,
            ),
            Wrap(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Giá vàng lập đỉnh 80 triệu, Giá vàng hôm nay, Ngân hàng Nhà nước Việt Nam',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Colors.black,
                  //     spreadRadius: 0.3,
                  //     blurRadius: 6,
                  //   )
                  // ]),
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
                      decoration: BoxDecoration(),
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
      drawer: const drawer(),
    );
  }
}
