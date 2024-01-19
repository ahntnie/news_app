import '../Model/User.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> setUser(Users user) async {
    return await UserRepository.setUser(user);
  }

  static getUsers() async {
    return await UserRepository.getUsers();
  }
}
