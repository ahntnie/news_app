import '../Model/Users.dart';
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

  static List<Users> lstUsers = List.filled(
      0,
      Users(
          name: "",
          email: "",
          password: "",
          birth: DateTime.now(),
          phone: "",
          gender: true),
      growable: true);
  static Future<void> getUsers() async {
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
}
