import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_events.dart';
import 'package:my_finance_apps/app/modules/home/bloc/home_states.dart';

class HomePageBlocs extends Bloc<HomePageEvents, HomePageStates> {
  HomePageBlocs() : super(HomePageStates()) {
    on<HomePageIndex>(_homePageIndex);
    on<UserDataLogin>(_onUserDataLogin);
  }

  void _homePageIndex(HomePageIndex event, Emitter<HomePageStates> emit) {
    // emit(HomePageStates(indexMenu: state.indexMenu));
    emit(state.copyWith(indexMenu: event.indexMenu));
  }

  void _onUserDataLogin(UserDataLogin event, Emitter<HomePageStates> emit) {
    emit(state.copyWith(userData: event.userData));
  }
}
