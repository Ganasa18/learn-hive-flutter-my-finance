// import 'package:equatable/equatable.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';

class WalletStates {
  // @override
  // List<Object> get props => [];
  List<Wallet>? wallets;
  Wallet? wallet;
  List<Map<String, dynamic>>? expenseList;
  List<Map<String, dynamic>>? incomeList;
  int? expenseAmount;
  int? incomeAmount;

  WalletStates({
    this.wallets,
    this.wallet,
    this.expenseList,
    this.incomeList,
    this.expenseAmount,
    this.incomeAmount,
  });

  WalletStates copyWith({
    Wallet? wallet,
    List<Wallet>? wallets,
    List<Map<String, dynamic>>? expenseList,
    List<Map<String, dynamic>>? incomeList,
    int? expenseAmount,
    int? incomeAmount,
  }) {
    return WalletStates(
        wallet: wallet ?? this.wallet,
        wallets: wallets ?? this.wallets,
        expenseList: expenseList ?? this.expenseList,
        incomeList: incomeList ?? this.incomeList,
        expenseAmount: expenseAmount ?? this.expenseAmount,
        incomeAmount: incomeAmount ?? this.incomeAmount);
  }
}

// class WalletInitialState extends WalletStates {}

// class WalletDataState extends WalletStates {
//   final List<Wallet> wallets;
//   const WalletDataState(this.wallets);

//   @override
//   List<Object> get props => [wallets];
// }
