import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_states.dart';

class TransactionBloc extends Bloc<TransactionEvents, TransactionStates> {
  TransactionBloc() : super(TransactionStates()) {
    on<SelectedTransactionType>(_onChangeTransactionType);
    on<SetAmountTransaction>(_setAmountTransaction);

    on<SetCategoryTransaction>(_setCategoryTransaction);
    on<SetSelectedIcon>(_setSelectedIcon);

    on<SetFormCreateCategory>(_setFormCreateCategory);
    on<SetSelectedWallet>(_setSelectedWallet);
    on<SetSelectedCategory>(_setSelectedCategory);

    on<ResetTransaction>(_resetTransactionState);
  }

  void _resetTransactionState(
      ResetTransaction event, Emitter<TransactionStates> emit) {
    emit(TransactionStates());
  }

  void _onChangeTransactionType(
      SelectedTransactionType event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(typeTransaction: event.typeTransaction));
  }

  void _setAmountTransaction(
      SetAmountTransaction event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _setSelectedIcon(
      SetSelectedIcon event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(chipIndex: event.chipIndex));
  }

  void _setFormCreateCategory(
      SetFormCreateCategory event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(category: event.category));
  }

  void _setSelectedWallet(
      SetSelectedWallet event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(wallet: event.wallet));
  }

  void _setSelectedCategory(
      SetSelectedCategory event, Emitter<TransactionStates> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _setCategoryTransaction(
      SetCategoryTransaction event, Emitter<TransactionStates> emit) async {
    emit(state.copyWith(categories: event.categories));
  }
}
