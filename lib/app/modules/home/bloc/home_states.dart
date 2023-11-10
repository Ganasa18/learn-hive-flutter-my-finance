import 'package:my_finance_apps/app/data/models/user_model.dart';

class HomePageStates {
  final int indexMenu;
  User? userData;
  HomePageStates({this.indexMenu = 0, this.userData});

  HomePageStates copyWith({int? indexMenu, User? userData}) {
    return HomePageStates(
      indexMenu: indexMenu ?? this.indexMenu,
      userData: userData ?? this.userData,
    );
  }
}
