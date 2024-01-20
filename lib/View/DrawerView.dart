import 'package:flutter/material.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/View/CategoryNewView.dart';
import 'package:news_app/View/CategoryView.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/SearchView.dart';


class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

bool onTap_ThoiSu = false;
bool onTap_TheThao = false;
bool onTap_NgheThuat = false;
bool onTap_GiaoDuc = false;
TextEditingController txt_Search = TextEditingController();

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  height: 60,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextField(
                    onChanged: (value) async {
                      setState(() {
                        txt_Search.text = value;
                      });
                    },
                    controller: txt_Search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      hintText: 'Tìm kiếm...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (txt_Search.text.isEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView(
                                            string_news: txt_Search.text,
                                          )));
                            }
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const ListTile(
            title: Text(
              'Chuyên mục',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeView()));
              },
              title: Container(
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: const Text(
                  "Trang chủ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )),
          ListTile(
            onTap: () {
              setState(() {
                onTap_ThoiSu = !onTap_ThoiSu;
              });
            },
            title: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thời sự",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        onTap_ThoiSu
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        size: 35,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                if (onTap_ThoiSu) selectMethod("Thời sự")
              ],
            ),
          ),
          ListTile(
              onTap: () {
                setState(() {
                  onTap_TheThao = !onTap_TheThao;
                });
              },
              title: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Thể thao",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          onTap_TheThao
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          size: 35,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  if (onTap_TheThao) selectMethod("Thể thao")
                ],
              )),
          ListTile(
              onTap: () {
                setState(() {
                  onTap_NgheThuat = !onTap_NgheThuat;
                });
              },
              title: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nghệ thuật",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          onTap_NgheThuat
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          size: 35,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  if (onTap_NgheThuat) selectMethod("Nghệ thuật")
                ],
              )),
          ListTile(
              onTap: () {
                setState(() {
                  onTap_GiaoDuc = !onTap_GiaoDuc;
                });
              },
              title: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Giáo dục",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          onTap_GiaoDuc
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          size: 35,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  if (onTap_GiaoDuc) selectMethod("Giáo dục")
                ],
              )),
        ],
      ),
    );
  }

  SizedBox selectMethod(String name) {
    return SizedBox(
      child: Column(children: [
        ListTile(
          onTap: () {
            if (name == "Thời sự") {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryNewView(
                        news: NewsRepository.lstNews_ThoiSu[0],
                      )));
            } else if (name == "Thể thao") {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryNewView(
                        news: NewsRepository.lstNews_TheThao[0],
                      )));
            } else if (name == "Giáo dục") {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryNewView(
                        news: NewsRepository.lstNews_GiaoDuc[0],
                      )));
            } else {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryNewView(
                        news: NewsRepository.lstNews_NgheThuat[0],
                      )));
            }
          },
          title: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: const Text(
              "Tin mới nhất",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          title: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: const Text(
              "Ảnh / Video",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryView(name: name)));
          },
          title: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            child: const Text(
              "Xem nhiều",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ),
      ]),
    );
  }
}
