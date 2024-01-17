import '../Model/User.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> getUser(Users user) async {
    return await UserRepository.setUser(user);
  }
}
