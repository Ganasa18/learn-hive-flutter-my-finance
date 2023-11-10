import 'package:my_finance_apps/app/data/models/user_model.dart';

class HomePageEvents {
  const HomePageEvents();
}

class HomePageIndex extends HomePageEvents {
  final int indexMenu;
  const HomePageIndex(this.indexMenu) : super();
}

class UserDataLogin extends HomePageEvents {
  final User? userData;
  UserDataLogin(this.userData);
}
