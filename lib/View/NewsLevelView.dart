// import 'package:flutter/material.dart';
// import 'package:news_app/Model/Category.dart';
// import 'package:news_app/Model/News.dart';
// import 'package:news_app/View/HomeView.dart';
// import 'package:news_app/View/NewsScreen_Detail.dart';

// class NewsLevel extends StatefulWidget {
//   const NewsLevel({super.key});

//   @override
//   State<NewsLevel> createState() => _NewsLevelState();
// }

// int _selectedIndex = 0;
// final list = [
//   'assets/image/introdutory.png',
//   'assets/image/introdutory.png',
//   'assets/image/introdutory.png',
//   'assets/image/introdutory.png'
// ];
// final urlImages = [
//   'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
//   'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
//   'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
//   'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
//   'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
// ];

// // final categories = [
// //   CategoryModel(categoryName: "Thể thao", image: "assets/image/thethao.jpg"),
// //   CategoryModel(categoryName: "Thời sự", image: "assets/image/thoisu.jpg"),
// //   CategoryModel(categoryName: "Giáo dục", image: "assets/image/giaoduc.jpg"),
// //   CategoryModel(
// //       categoryName: "Nghệ thuật", image: "assets/image/nghethuat.jpg"),
// // ];


// bool onTap_ThoiSu = false;
// bool onTap_TheThao = false;
// bool onTap_NgheThuat = false;
// bool onTap_GiaoDuc = false;

// class _NewsLevelState extends State<NewsLevel> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             width: MediaQuery.of(context).size.width / 2.2,
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("VLTT "),
//                 Text(
//                   "Tin tức",
//                   style: TextStyle(color: Colors.blue),
//                 )
//               ],
//             ),
//           ),
//           centerTitle: true,
//         ),
//         drawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 padding: const EdgeInsets.symmetric(horizontal: 1),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       color: Colors.grey.shade300,
//                       width: double.infinity,
//                       height: 60,
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("VLTT "),
//                           Text(
//                             "Tin tức",
//                             style: TextStyle(color: Colors.blue),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 20),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.all(8),
//                           hintText: 'Tìm kiếm...',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           suffixIcon: const Icon(Icons.search),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const ListTile(
//                 title: Text(
//                   'Chuyên mục',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               ListTile(
//                   onTap: () {},
//                   title: Container(
//                     alignment: Alignment.topLeft,
//                     decoration: const BoxDecoration(
//                         border:
//                             Border(bottom: BorderSide(color: Colors.black))),
//                     child: const Text(
//                       "Trang chủ",
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   )),
//               ListTile(
//                 onTap: () {
//                   setState(() {
//                     onTap_ThoiSu = !onTap_ThoiSu;
//                   });
//                 },
//                 title: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.topLeft,
//                       decoration: const BoxDecoration(
//                           border:
//                               Border(bottom: BorderSide(color: Colors.black))),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Thời sự",
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                           Icon(
//                             onTap_ThoiSu
//                                 ? Icons.keyboard_arrow_down_outlined
//                                 : Icons.keyboard_arrow_up_outlined,
//                             size: 35,
//                             color: Colors.black,
//                           )
//                         ],
//                       ),
//                     ),
//                     if (onTap_ThoiSu)
//                       SizedBox(
//                         child: Column(children: [
//                           ListTile(
//                             onTap: () {},
//                             title: Container(
//                               alignment: Alignment.topLeft,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(color: Colors.black))),
//                               child: const Text(
//                                 "Tin mới nhất",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 10),
//                               ),
//                             ),
//                           ),
//                           ListTile(
//                             onTap: () {},
//                             title: Container(
//                               alignment: Alignment.topLeft,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(color: Colors.black))),
//                               child: const Text(
//                                 "Ảnh / Video",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 10),
//                               ),
//                             ),
//                           ),
//                           ListTile(
//                             onTap: () {},
//                             title: Container(
//                               alignment: Alignment.topLeft,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(color: Colors.black))),
//                               child: const Text(
//                                 "Xem nhiều",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 10),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       )
//                   ],
//                 ),
//               ),
//               ListTile(
//                   onTap: () {
//                     setState(() {
//                       onTap_TheThao = !onTap_TheThao;
//                     });
//                   },
//                   title: Column(
//                     children: [
//                       Container(
//                         alignment: Alignment.topLeft,
//                         decoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.black))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Thể thao",
//                               style: TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Icon(
//                               onTap_TheThao
//                                   ? Icons.keyboard_arrow_down_outlined
//                                   : Icons.keyboard_arrow_up_outlined,
//                               size: 35,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                       ),
//                       if (onTap_TheThao)
//                         SizedBox(
//                           child: Column(children: [
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Tin mới nhất",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Ảnh / Video",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Xem nhiều",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         )
//                     ],
//                   )),
//               ListTile(
//                   onTap: () {
//                     setState(() {
//                       onTap_NgheThuat = !onTap_NgheThuat;
//                     });
//                   },
//                   title: Column(
//                     children: [
//                       Container(
//                         alignment: Alignment.topLeft,
//                         decoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.black))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Nghệ thuật",
//                               style: TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Icon(
//                               onTap_NgheThuat
//                                   ? Icons.keyboard_arrow_down_outlined
//                                   : Icons.keyboard_arrow_up_outlined,
//                               size: 35,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                       ),
//                       if (onTap_NgheThuat)
//                         SizedBox(
//                           child: Column(children: [
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Tin mới nhất",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Ảnh / Video",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Xem nhiều",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         )
//                     ],
//                   )),
//               ListTile(
//                   onTap: () {
//                     setState(() {
//                       onTap_GiaoDuc = !onTap_GiaoDuc;
//                     });
//                   },
//                   title: Column(
//                     children: [
//                       Container(
//                         alignment: Alignment.topLeft,
//                         decoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.black))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Giáo dục",
//                               style: TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Icon(
//                               onTap_GiaoDuc
//                                   ? Icons.keyboard_arrow_down_outlined
//                                   : Icons.keyboard_arrow_up_outlined,
//                               size: 35,
//                               color: Colors.black,
//                             )
//                           ],
//                         ),
//                       ),
//                       if (onTap_GiaoDuc)
//                         SizedBox(
//                           child: Column(children: [
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Tin mới nhất",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Ảnh / Video",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {},
//                               title: Container(
//                                 alignment: Alignment.topLeft,
//                                 decoration: const BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.black))),
//                                 child: const Text(
//                                   "Xem nhiều",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         )
//                     ],
//                   )),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(children: [
//             // Container(
//             //   margin: const EdgeInsets.only(left: 10.0),
//             //   height: 70,
//             //   child: ListView.builder(
//             //       shrinkWrap: true,
//             //       scrollDirection: Axis.horizontal,
//             //       itemCount: categories.length,
//             //       itemBuilder: (context, index) {
//             //         return CategoryTile(
//             //           image: categories[index].image,
//             //           categoryName: categories[index].categoryName,
//             //         );
//             //       }),
//             // ),
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     titleCategory("Thời sự"),
//                     newsCard(context, lstNews[0].title, lstNews[0].content,
//                         lstNews[0].img),
//                     newsCard(context, lstNews[1].title, lstNews[1].content,
//                         lstNews[1].img),
//                     newsCard(context, lstNews[2].title, lstNews[2].content,
//                         lstNews[2].img),
//                     newsCard(context, lstNews[3].title, lstNews[3].content,
//                         lstNews[3].img),
//                     newsCard(context, lstNews[0].title, lstNews[0].content,
//                         lstNews[0].img),
//                     newsCard(context, lstNews[1].title, lstNews[1].content,
//                         lstNews[1].img),
//                     newsCard(context, lstNews[2].title, lstNews[2].content,
//                         lstNews[2].img),
//                     newsCard(context, lstNews[3].title, lstNews[3].content,
//                         lstNews[3].img),
//                   ],
//                 )),
//             const Divider(),
//             const SizedBox(
//               width: double.infinity,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10, top: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.phone,
//                           size: 20,
//                         ),
//                         Text(
//                           "Điện thoại: ",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         Text(
//                           "0938523503",
//                           style: TextStyle(color: Colors.red, fontSize: 10),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on),
//                         Text(
//                           "Địa chỉ: ",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         Expanded(
//                             child: Text(
//                           "65 Huỳnh Thúc Kháng, Quận 1, TP Hồ Chí Minh",
//                           style: TextStyle(fontSize: 10),
//                         ))
//                       ],
//                     ),
//                     Text(
//                       "Tổng biên tập: Lê Hữu Thành",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                     Text(
//                       "Phó tổng biên tập: Bùi Thanh Viên",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                     Text(
//                       "Phó tổng biên tập: Bạch Anh Tiến",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                     Text(
//                       "Phó tổng biên tập: Phạm Ngọc Liêm",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                     SizedBox(
//                       height: 7,
//                     ),
//                     Text(
//                       "Cấm sao chép với mọi hình thức nếu không có sự chấp thuận bằng văn bản",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ]),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.grey.shade300,
//           currentIndex: _selectedIndex,
//           onTap: (int index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//             if (_selectedIndex == 0) {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const HomeView()));
//             } else if (_selectedIndex == 1) {
//               // Xử lý khi mục thứ hai được chọn
//             } else if (_selectedIndex == 2) {
//               // Xử lý khi mục thứ ba được chọn
//             }
//           },
//           items: [
//             const BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                   size: 30,
//                 ),
//                 label: 'Trang chủ'),
//             const BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.notifications,
//                   size: 30,
//                 ),
//                 label: 'Thông báo'),
//             BottomNavigationBarItem(
//                 icon: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(50)),
//                   child: Image.asset(
//                     "assets/image/vien.jpg",
//                     fit: BoxFit.cover,
//                     height: 30,
//                     width: 30,
//                   ),
//                 ),
//                 label: 'Cá nhân'),
//           ],
//         ),
//       ),
//     );
//   }

//   ListTile newsCard(
//       BuildContext context, String title, String content, String img) {
//     return ListTile(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const NewsDetail()));
//       },
//       title: Container(
//         // margin: const EdgeInsets.only(top: 5, bottom: 5),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.grey.shade200),
//         // color: Colors.grey.shade200,
//         width: double.infinity,
//         child: Row(
//           children: [
//             SizedBox(
//               width: 100,
//               height: 100,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 child: Image.network(
//                   img,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 5.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       content,
//                       style: const TextStyle(
//                         fontSize: 8,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Row titleCategory(String name) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: () {},
//           child: const Text(
//             "Thời sự ",
//             style: TextStyle(color: Color.fromARGB(255, 250, 19, 2)),
//           ),
//         ),
//         const Text("/", style: TextStyle(fontSize: 23)),
//         InkWell(
//           onTap: () {},
//           child: const Text(
//             " Tin mới nhất",
//             style: TextStyle(color: Color.fromARGB(255, 207, 91, 80)),
//           ),
//         ),
//       ],
//     );
//   }
// }
