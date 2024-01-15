import '../Model/User.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
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
    // var ref = await FirebaseDatabase.instance
    //     .ref()
    //     .child("user")
    //     .child(user.phone)
    //     .set(_user)
    //     .then((value) {
    //   print("Thêm thành công");
    // }).catchError((onError) {
    //   print("Thêm thất bại");
    // });
    final ref1 = FirebaseDatabase.instance.ref().child("user");
    ref1.child(user.name.toString()).set(_user).then((value) {
      print("Thêm tài khoản thành công");
    }).catchError((onError) {
      print('Thêm tài khoản không thành công $onError');
    });
  }
}
