import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/app/data/providers/user_provider.dart';

class UserRepository {
  UserProvider userProvider;
  UserRepository(this.userProvider);

  Future<void> emptyHiveBoxUser() {
    return userProvider.emptyHiveBoxUser();
  }

  Future<void> createUser(User user) {
    return userProvider.createUser(user);
  }

  Future<User?> getUser(int userId) {
    return Future.delayed(const Duration(seconds: 1), () {
      return userProvider.getUser(userId);
    });
  }
}
