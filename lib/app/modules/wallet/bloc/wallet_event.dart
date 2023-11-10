import 'package:equatable/equatable.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';

class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object?> get props => [];
}

class SetWalletList extends WalletEvent {
  final List<Wallet> wallets;
  const SetWalletList(this.wallets);
  @override
  List<Object?> get props => [wallets];
}

class SetWalletSelect extends WalletEvent {
  final Wallet? wallet;
  const SetWalletSelect(this.wallet);
  @override
  List<Object?> get props => [wallet];
}

class SetWalletTransactionExpense extends WalletEvent {
  final List<Map<String, dynamic>>? expenseList;
  const SetWalletTransactionExpense(this.expenseList);
  @override
  List<Object?> get props => [expenseList];
}

class SetWalletTransactionIncome extends WalletEvent {
  final List<Map<String, dynamic>>? incomeList;
  const SetWalletTransactionIncome(this.incomeList);
  @override
  List<Object?> get props => [incomeList];
}

class SetCountTotalAmountCard extends WalletEvent {
  final int expenseAmount;
  final int incomeAmount;
  const SetCountTotalAmountCard(this.expenseAmount, this.incomeAmount);
  @override
  List<Object?> get props => [expenseAmount, incomeAmount];
}
