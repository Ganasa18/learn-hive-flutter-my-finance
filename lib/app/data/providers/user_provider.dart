import 'package:my_finance_apps/app/data/models/user_model.dart';
import 'package:my_finance_apps/app/data/services/user_service.dart';

class UserProvider {
  UserStorageService userStorageService;
  UserProvider(this.userStorageService);

  Future<void> emptyHiveBoxUser() {
    return userStorageService.emptyHiveBoxUser();
  }

  Future<void> createUser(User user) {
    return userStorageService.createUser(user);
  }

  Future<User?> getUser(int userId) {
    return userStorageService.readUser(userId);
  }
}
