import '../Model/User.dart';
import '../Repository/UserRepository.dart';

class UserPresenter {
  final UserRepository repository;

  UserPresenter(this.repository);

  Future<User> getUser(String id) async {
    return await repository.getUser(id);
  }
}