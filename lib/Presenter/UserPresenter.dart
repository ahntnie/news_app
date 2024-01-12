import '../Model/User.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> getUser(User user) async {
    return await UserRepository.setUser(user);
  }
}