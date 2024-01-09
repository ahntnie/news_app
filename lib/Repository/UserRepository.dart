import '../Model/User.dart';

class UserRepository {
  Future<User> getUser(String id) async {
    // Lấy dữ liệu từ API hoặc từ database
    return User(name: "John Doe", age: 30);
  }
}