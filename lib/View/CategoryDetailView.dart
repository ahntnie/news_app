import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/Comment.dart';
import 'package:news_app/Model/News.dart';
import 'package:news_app/Presenter/CommentPresenter.dart';
import 'package:news_app/Repository/CommentRepository.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:news_app/View/CategoryNewView.dart';
import 'package:news_app/View/CategoryView.dart';
import 'package:news_app/View/LoginView.dart';

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({
    super.key,
    required this.news,
  });
  final News news;
  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _CategoryDetailViewState extends State<CategoryDetailView> {
  List<Widget> lstComment = [];
  List<Comment> lstGetCmt = [];
  Future<void> getComment() async {
    //lstComment
    //print("Vào get nè");
    setState(() {
      //print(widget.news.title.toString());
      CommentPresenter.getComment(
        widget.news.title.toString(),
      ).then((value) {
        setState(() {
          lstGetCmt = CommentRepository.lstComments;
          lstComment = lstGetCmt.map((e) => BoxComment(e)).toList();
        });
      });
    });
  }

  void addComment(Comment comment) {
    setState(() {
      lstComment.add(
        BoxComment(comment),
      );
      lstGetCmt.add(comment);
      CommentRepository.lstComments = lstGetCmt;
    });
  }

  bool isLike = false;
  int like = 0;
  Future<void> likeComment(Comment cmt) async {
    var ref = await FirebaseDatabase.instance
        .ref()
        .child("comment")
        .child(cmt.title)
        .get();
    List<String> lstLike = [];
    for (var _cmt in ref.children) {
      if (cmt.time == _cmt.child("time").value.toString()) {
        for (var count = 0;
            count < _cmt.child("lstLike").children.length;
            count++) {
          lstLike.add(
              _cmt.child("lstLike").child(count.toString()).value.toString());
        }
        if (lstLike.contains(UserRepository.user.email.toString())) {
          lstLike.remove(UserRepository.user.email.toString());

          if (cmt.time == _cmt.child("time").value.toString()) {
            isLike = false;
            like = lstLike.length;
          }
        } else {
          lstLike.add(UserRepository.user.email.toString());

          if (cmt.time == _cmt.child("time").value.toString()) {
            isLike = true;
            like = lstLike.length;
          }
        }

        await FirebaseDatabase.instance
            .ref()
            .child("comment")
            .child(cmt.title)
            .child(_cmt.key.toString())
            .child("lstLike")
            .set(lstLike)
            .then((value) {})
            .catchError((onError) {
          print('Tăng like không thành công');
        });
        break;
      }
    }
  }

  bool flagg = false;
  Container BoxComment(Comment cmt) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade300),
      ),
      width: 350,
      constraints: const BoxConstraints(
        minHeight: 100.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                // height: 80,
                decoration: const BoxDecoration(),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40, left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Image.asset(
                              "assets/image/vien.jpg",
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  cmt.email.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(cmt.time)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (UserRepository.user.email!.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Thông báo'),
                                            content: const Text(
                                                'Vui lòng đăng nhập để bình luận'),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      // Chuyển sang tap đăng nhập khi chưa đăng nhập
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Đóng'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // Chuyển sang tap đăng nhập khi chưa đăng nhập
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginView()));
                                                    },
                                                    child:
                                                        const Text('Đăng nhập'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      likeComment(cmt);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isLike ? Colors.red : null,
                                  ),
                                ),
                                Text(like != 0 ? "${like}" : "")
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                cmt.content,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

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

    CommentRepository.lstComments = List.filled(
        0,
        Comment(
          lstLike: [],
          title: "",
          nameUser: "",
          email: "",
          content: "",
          time: "",
        ),
        growable: true);
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
        // ignore: unused_local_variable
        for (var element in fullClass) {
          final imageElement = document.querySelectorAll('.fig-picture');
          for (var e in imageElement) {
            final img = e.outerHtml
                .toString()
                .substring(
                  e.outerHtml.toString().lastIndexOf("srcset=") + 8,
                  e.outerHtml.toString().lastIndexOf("1x"),
                )
                .replaceAll("amp;", '');

            imageUrls.add(img.trim());
          }
        }

        //print(fullClass[0].toString().split('div class="fig-picture"'));

        setState(() {
          flag = false;
          contents = fullClass.map((e) => e.innerHtml).toList();

          test = contents[0].split('<figure data-size="true"');

          for (var txt in test) {
            test1 = test1 + txt.split("</picture></div>");
          }
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    getComment();
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
      body: DetailView(context, count, count1),
    );
  }

  SingleChildScrollView DetailView(
      BuildContext context, int count, int count1) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: widgetTitleContentImage(context, count, count1),
      ),
    );
  }

  Column widgetTitleContentImage(BuildContext context, int count, int count1) {
    return Column(
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
                    color: Color.fromARGB(255, 207, 91, 80), fontSize: 23),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: test1.map((e) {
            int index = test1.length > count ? count++ : test1.length - 1;
            return index.isEven
                ? Html(data: test1[index])
                : ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(imageUrls[imageUrls.length > count1
                        ? count1++
                        : imageUrls.length - 1]),
                  );
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
        wigetComment(context),
        const SizedBox(
          height: 15,
        ),
        Column(children: lstGetCmt.map((e) => BoxComment(e)).toList()),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container wigetComment(BuildContext context) {
    return Container(
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
                  onPressed: () {
                    setState(() {
                      if (UserRepository.user.email!.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thông báo'),
                              content:
                                  const Text('Vui lòng đăng nhập để bình luận'),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Chuyển sang tap đăng nhập khi chưa đăng nhập
                                        Navigator.of(context).pop();
                                        cmt.clear();
                                      },
                                      child: const Text('Đóng'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Chuyển sang tap đăng nhập khi chưa đăng nhập
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginView()));
                                      },
                                      child: const Text('Đăng nhập'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        //print(_currentUser!.displayName.toString());
                        if (cmt.text.isNotEmpty) {
                          CommentRepository.setComment(Comment(
                            lstLike: [],
                            content: cmt.text,
                            email: UserRepository.user.email.toString(),
                            time: DateTime.now().toString().substring(0, 19),
                            nameUser: UserRepository.user.name.toString(),
                            title: widget.news.title,
                          ));
                          addComment(Comment(
                            lstLike: [],
                            content: cmt.text,
                            email: UserRepository.user.email.toString(),
                            time: DateTime.now().toString().substring(0, 19),
                            nameUser: UserRepository.user.name.toString(),
                            title: widget.news.title,
                          ));
                          cmt.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Thông báo'),
                                content: const Text('Vui lòng nhập bình luận'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Đóng hộp thoại khi người dùng nhấn nút
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    });
                  },
                  icon: const Icon(Icons.send)))),
    );
  }
}
