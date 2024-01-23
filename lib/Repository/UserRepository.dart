import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Users.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  static List<Users> lstUsers = List.filled(
      // danh sách tài khoản người dùng
      0,
      Users(
          name: "",
          email: "",
          password: "",
          birth: DateTime.now(),
          phone: "",
          gender: true),
      growable: true);

  static Users? user;

  static Future<void> saveUser(Users? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user!.toJson());
    await prefs.setString('User', stringUser);
  }

  static Future<Users?> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = prefs.getString('User') ?? "";
    user = Users.fromJson(jsonDecode(stringUser));
    return user;
  }

  static Future<void> setUser(Users user) async {
    // Lấy dữ liệu từ API hoặc từ database
    var user0 = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "phone": user.phone,
      "gender": user.gender,
      "birth": user.birth.toString()
    };
    final ref1 = FirebaseDatabase.instance.ref().child("user");
    ref1.child(user.name.toString()).set(user0).then((value) {
      print("Thêm tài khoản thành công");
    }).catchError((onError) {
      print('Thêm tài khoản không thành công $onError');
    });
  }

  static Future<void> getUsers() async {
    //lấy danh sách tài khoản người dùng
    var response = await FirebaseDatabase.instance.ref().child("user").get();

    for (DataSnapshot users in response.children) {
      if (users.key.toString() == "name") {
        for (DataSnapshot user in response.child("name").children) {
          if (response.children.length > lstUsers.length) {
            lstUsers.add(Users(
                name: user.child("name").value.toString(),
                email: user.child("email").value.toString(),
                password: user.child("password").value.toString(),
                phone: user.child("phone").value.toString(),
                birth: user.child("birth").value as DateTime,
                gender: bool.parse(user.child("gender").value.toString())));
          }
        }
        //print("Comment nè ${comment.value.toString()}");
      }
    }
  }

  static Future<void> getUser(Users user) async {
    var user0 = {
      "name": user.name,
      "email": user.email,
    };
    final ref1 = FirebaseDatabase.instance.ref().child("user");
    ref1.child(user.name.toString()).get().then((value) {
      print("lấy tên tài khoản thành công ");
    }).catchError((onError) {
      print('lấy tên tài khoản không thành công $onError');
    });
  }

  static Future<void> updateUserInfo(
      String username, String phone, String birth) async {
    DatabaseReference ref1 =
        FirebaseDatabase.instance.ref().child("user/$username/");
    await ref1.update({"phone": phone, "birth": birth});
  }

  static Future<void> updateGoogleUserInfo(String phone, String name) async {
    var Gguser = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        user.updatePhoneNumber(phone as PhoneAuthCredential);
        user.updateDisplayName(name);
      }
    });
  }
}
