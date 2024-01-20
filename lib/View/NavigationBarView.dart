import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/LoginView.dart';
import 'package:news_app/View/NotificationView.dart';

import 'ProfileView.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.idx});
  final idx;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
// String? name = FirebaseAuth.instance.currentUser!.displayName;
// String? avatar = FirebaseAuth.instance.currentUser!.photoURL;
var _currentUser = auth.currentUser;
TextEditingController txt_RoomName = TextEditingController();
Future<bool> checkLoginStatus(String email) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password:
          'password', // Đổi 'password' thành mật khẩu tương ứng với tài khoản
    );
    return true; // Tài khoản đã đăng nhập
  } catch (e) {
    return false; // Tài khoản chưa đăng nhập hoặc xảy ra lỗi
  }
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
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
            icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.asset(
                  "assets/image/vien.jpg",
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                )),
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationView()));
          }
        }
        if (indexOfItem == 2) {
          if (widget.idx != 2) {
            _currentUser == null
                ? Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginView()))
                :

                // Trang profile
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileView()));
          }
        }
      },
    );
  }
}
