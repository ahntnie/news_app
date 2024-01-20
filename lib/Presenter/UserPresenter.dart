import '../Model/Users.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> setUser(Users user) async {
    return await UserRepository.setUser(user);
  }

  static getUsertoList() async {
    return await UserRepository.getUsertoList();
  }

  static getUser(Users user) async {
    return await UserRepository.getUser(user);
  }

  static var user = UserRepository.user;
}
