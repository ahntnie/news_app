import 'package:flutter/material.dart';
import 'package:news_app/Model/Users.dart';
import 'package:news_app/Presenter/UserPresenter.dart';
import 'package:news_app/View/HomeView.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // UserPresenter.getUser(Users(
    //     name: "Lê Hữu Thành",
    //     email: "thanh@gmail.com",
    //     password: "123",
    //     birth: DateTime(2003, 5, 23),
    //     phone: "09876556544",
    //     gender: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/introdutory.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 9,
                vertical: MediaQuery.of(context).size.height / 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "TIN TỨC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 13,
                        width: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.pink.shade800)),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: MediaQuery.of(context).size.height / 14,
                              color: Colors.black,
                            )),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
