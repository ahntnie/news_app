import '../Model/Users.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> setUser(Users user) async {
    return await UserRepository.setUser(user);
  }
}