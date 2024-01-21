import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/LoginView.dart';
import 'package:news_app/View/NotificationView.dart';
import '../Model/Users.dart';
import 'ProfileView.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.idx});
  final idx;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

Users _user = Users(
    name: "",
    email: "",
    password: "",
    birth: DateTime(2024),
    phone: "",
    gender: true);
TextEditingController txt_RoomName = TextEditingController();

class _BottomNavState extends State<BottomNav> {
  Future<void> getUser() async {
    UserRepository.loadUser().then((value) {
      setState(() {
        _user = UserRepository.user!;
      });
    }).catchError((onError) {
      // print("Lấy user không thành công");
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    //print(name);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: (widget.idx == 0) ? Colors.blue : Colors.grey,
          ),
          label: "Trang chủ",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: (widget.idx == 1) ? Colors.blue : Colors.grey,
            ),
            label: "Thông báo"),
        BottomNavigationBarItem(
            icon: UserRepository.user!.email!.isNotEmpty
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      "assets/image/vien.jpg",
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ))
                : const Icon(
                    Icons.account_circle_rounded,
                    size: 30,
                  ),
            label: "Tài khoản"),
      ],
      currentIndex: widget.idx,
      onTap: (int indexOfItem) {
        if (indexOfItem == 0) {
          print("Trang chủ");
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomeView()));
        }
        if (indexOfItem == 1) {
          if (widget.idx != 1) {
            print("Thông báo");
            //Trang thông báo
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NotificationView()));
          }
        }
        if (indexOfItem == 2) {
          if (widget.idx != 2) {
            if (UserRepository.user!.email.toString().isEmpty) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginView()));
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            }
          }
        }
      },
    );
  }
}
