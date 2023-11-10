import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_states.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvents, DashboardPageStates> {
  DashboardPageBloc() : super(DashboardPageStates()) {
    on<CategoryActiveIndex>(_onActiveCategory);
    on<SetTotalAmountWallet>(_onSetTotalAmountWallet);
    on<SetTransactionList>(_onSetTransactionList);
  }

  void _onActiveCategory(
      CategoryActiveIndex event, Emitter<DashboardPageStates> emit) {
    emit(state.copyWith(activeCategory: event.categoryActive));
  }

  void _onSetTotalAmountWallet(
      SetTotalAmountWallet event, Emitter<DashboardPageStates> emit) {
    emit(state.copyWith(totalAmountWallet: event.totalAmountWallet));
  }

  void _onSetTransactionList(
      SetTransactionList event, Emitter<DashboardPageStates> emit) {
    emit(state.copyWith(transactionList: event.transactionList));
  }
}
