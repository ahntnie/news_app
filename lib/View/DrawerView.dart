import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/View/HomeView.dart';

import '../Model/News.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

final lstNews = [
  News(
    title:
        "Bí thư Hà Nội: Sớm xây ba cầu vượt sông Hồng, Đuống trên vành đai 4",
    content:
        "HÀ NỘI __ Để khai thác đường song hành vành đai 4 cuối năm 2025, phải sớm xây cầu Mễ Sở, Hồng Hà vượt sông Hồng và Hoài Thượng qua sông Đuống, theo Bí thư Hà Nội.",
    img:
        "https://i1-vnexpress.vnecdn.net/2024/01/04/cauhongha-1704369441-8047-1704369899.png?w=240&h=144&q=100&dpr=1&fit=crop&s=dCjJCJpKAK2p4dzZC5o7cQ",
  ),
  News(
    title: "Dugarry: 'Mbappe đang trì trệ ở PSG'",
    content:
        "PHÁP __ Cựu tiền đạo Pháp Christophe Dugarry khuyên Kylian Mbappe nên rời PSG sớm để thôi làm phiền đội bóng.",
    img:
        "https://i1-thethao.vnecdn.net/2024/01/04/mbappe-3529-1704305353-1704328-9077-7792-1704328646.jpg?w=&h=&q=100&dpr=1&fit=crop&s=s_JLDJ_J2nSDiXOJJGlznw",
  ),
  News(
    title:
        "20 đại học Mỹ hỗ trợ tài chính hào phóng nhất cho sinh viên quốc tế",
    content:
        "20 đại học hào phóng nhất hỗ trợ cho sinh viên quốc tế trung bình 77.000 USD (1,87 tỷ đồng) một năm, cao hơn... ",
    img:
        "https://i1-vnexpress.vnecdn.net/2023/12/30/406446658-381434821070997-4506-8994-3901-1703953071.png?w=380&h=228&q=100&dpr=1&fit=crop&s=YECovCY7JW4qkHIL_AqxxA",
  ),
  News(
    title:
        "Phong cách đặc trưng của Pharrell Williams trong BST đầu tiên tại Louis Vuitton",
    content:
        "Pharrell Williams khởi đầu chương mới tại Louis Vuitton với cương vị Giám đốc sáng tạo, lồng ghép dấu ấn cá nhân vào di sản thiết kế thương hiệu trong BST Xuân Hè 2024. ",
    img:
        "https://i1-giaitri.vnecdn.net/2024/01/03/image1081269697extractword0out-769767-1704269983-1704275809.jpeg?w=240&h=144&q=100&dpr=1&fit=crop&s=y04U7t3ckwApRXgnh7H-kA",
  ),
  News(
    title: "Giá xăng, dầu cùng giảm",
    content:
        "Mỗi lít xăng giảm 180-230 đồng, các mặt hàng dầu cũng hạ 190-500 đồng tùy loại, từ 15h hôm nay.",
    img:
        "https://i1-kinhdoanh.vnecdn.net/2024/01/04/xangdau2020ngocthanh-170433783-4368-6518-1704355152.jpg?w=220&h=132&q=100&dpr=1&fit=crop&s=ouIKM6_1Yk7iij1l1zf0ug",
  ),
];
bool onTap_ThoiSu = false;
bool onTap_TheThao = false;
bool onTap_NgheThuat = false;
bool onTap_GiaoDuc = false;

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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      hintText: 'Tìm kiếm...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.search),
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
                if (onTap_ThoiSu)
                  SizedBox(
                    child: Column(children: [
                      ListTile(
                        onTap: () {},
                        title: Container(
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
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
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: const Text(
                            "Ảnh / Video",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Container(
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: const Text(
                            "Xem nhiều",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ),
                    ]),
                  )
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
                  if (onTap_TheThao)
                    SizedBox(
                      child: Column(children: [
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Tin mới nhất",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Ảnh / Video",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Xem nhiều",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ]),
                    )
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
                  if (onTap_NgheThuat)
                    SizedBox(
                      child: Column(children: [
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Tin mới nhất",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Ảnh / Video",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Xem nhiều",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ]),
                    )
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
                  if (onTap_GiaoDuc)
                    SizedBox(
                      child: Column(children: [
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Tin mới nhất",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Ảnh / Video",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Container(
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: const Text(
                              "Xem nhiều",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ]),
                    )
                ],
              )),
        ],
      ),
    );
  }
}
