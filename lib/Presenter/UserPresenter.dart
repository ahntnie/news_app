import '../Model/Users.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> getUser(Users user) async {
    return await UserRepository.setUser(user);
  }

  static getUsers() async {
    return await UserRepository.getUsers();
  }
}
