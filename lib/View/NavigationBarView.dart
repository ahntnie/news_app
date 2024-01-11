import 'package:flutter/material.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/NotificationView.dart';

import 'ProfileView.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.idx});
  final idx;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class _BottomNavState extends State<BottomNav> {
  TextEditingController txt_RoomName = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              ),
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
            print("Tài khoản");
            // Trang profile
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileView()));
          }
        }
      },
    );
  }
}
