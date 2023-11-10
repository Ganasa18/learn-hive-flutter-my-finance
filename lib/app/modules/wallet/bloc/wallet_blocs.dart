import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_event.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_states.dart';

class WalletBloc extends Bloc<WalletEvent, WalletStates> {
  WalletBloc() : super(WalletStates()) {
    on<SetWalletList>(_onSetWalletList);
    on<SetWalletSelect>(_onSetWalletSelect);
    on<SetWalletTransactionExpense>(_onSetWalletTransactionExpense);
    on<SetWalletTransactionIncome>(_onSetWalletTransactionIncome);
    on<SetCountTotalAmountCard>(_onSetCountTotalAmountCard);
  }

  void _onSetWalletList(SetWalletList event, Emitter<WalletStates> emit) {
    emit(state.copyWith(wallets: event.wallets));
  }

  void _onSetWalletSelect(SetWalletSelect event, Emitter<WalletStates> emit) {
    emit(state.copyWith(wallet: event.wallet));
  }

  void _onSetWalletTransactionExpense(
      SetWalletTransactionExpense event, Emitter<WalletStates> emit) {
    emit(state.copyWith(expenseList: event.expenseList));
  }

  void _onSetWalletTransactionIncome(
      SetWalletTransactionIncome event, Emitter<WalletStates> emit) {
    emit(state.copyWith(incomeList: event.incomeList));
  }

  void _onSetCountTotalAmountCard(
      SetCountTotalAmountCard event, Emitter<WalletStates> emit) {
    emit(state.copyWith(
      expenseAmount: event.expenseAmount,
    ));
    emit(state.copyWith(
      incomeAmount: event.incomeAmount,
    ));
  }
}
