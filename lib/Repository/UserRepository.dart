import '../Model/User.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
static  Future<void> setUser(User user) async {
    // Lấy dữ liệu từ API hoặc từ database
    var _user = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "phone": user.phone,
      "gender": user.gender,
      "birth": user.birth
    };
    var ref = await FirebaseDatabase.instance
        .ref()
        .child("user")
        .child(user.phone)
        .set(_user)
        .then((value) {
      print("Thêm thành công");
    }).catchError((onError) {
      print("Thêm thất bại");
    });
  }
}
