import '../Model/Users.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  static Future<void> setUser(Users user) async {
    return await UserRepository.setUser(user);
  }
<<<<<<< HEAD
}
=======

  static getUsers() async {
    return await UserRepository.getUsers();
  }
}
>>>>>>> 732c3da58c2c7c448c7569c4532b018576c9610f
