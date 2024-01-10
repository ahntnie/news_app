import 'package:flutter/material.dart';

import 'NavigationBarView.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(
        idx: 1,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {},
        ),
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width / 2.2,
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("VLTT "),
              Text(
                "Tin tức",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              title: TabBar(
                indicator: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 4))),
                tabs: [
                  Tab(text: 'Thông báo'),
                  Tab(text: 'Phản hồi bình luận'),
                  Tab(text: 'Tin đã xem'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              // TAB Thông báo
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 5),
                        child: Text(
                          "Nghệ thuật",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 2.0,
                                  ),
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Text(
                                  "2h trước",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Thể thao",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2.0,
                                      ),
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: Text(
                                      "2h trước",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        "Thời sự",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.0,
                                        ),
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 20),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: Text(
                                      "2h trước",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        "Bất động sản",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.0,
                                        ),
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 20),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: Text(
                                      "2h trước",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // TAB Phản hồi bình luận
              SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 2.0,
                                  ),
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 250, top: 75),
                                  child: Text(
                                    "2h trước",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.0,
                                        ),
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 250, top: 75),
                                        child: Text(
                                          "2h trước",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 2.0,
                                            ),
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.5,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250, top: 75),
                                            child: Text(
                                              "2h trước",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 2.0,
                                            ),
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.5,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250, top: 75),
                                            child: Text(
                                              "2h trước",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Tab Tin đã xem
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "Nghệ thuật",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Text(
                        "2h trước",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 2.0,
                                  ),
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 20),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Thể thao",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Text(
                                  "2h trước",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2.0,
                                      ),
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 20),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        "Thời sự",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: Text(
                                      "2h trước",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.0,
                                        ),
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 20),
                                      ),
                                    ),
                                  ),
                                  const SingleChildScrollView(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          "Bất động sản",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200),
                                    child: Text(
                                      "2h trước",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 2.0,
                                        ),
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
