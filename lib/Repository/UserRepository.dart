import '../Model/User.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  static Users? User = null;
  static Future<void> setUser(Users user) async {
    // Lấy dữ liệu từ API hoặc từ database
    var _user = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "phone": user.phone,
      "gender": user.gender,
      "birth": user.birth.toString()
    };
    final ref1 = FirebaseDatabase.instance.ref().child("user");
    ref1.child(user.name.toString()).set(_user).then((value) {
      print("Thêm tài khoản thành công");
    }).catchError((onError) {
      print('Thêm tài khoản không thành công $onError');
    });
  }

  static Future<void> getUser(Users user) async {
    var _user = {
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

  static Users? user = null;
}
