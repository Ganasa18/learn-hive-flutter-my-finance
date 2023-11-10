import 'package:my_finance_apps/app/data/models/transaction_model.dart';

class DashboardPageStates {
  String activeCategory;
  int totalAmountWallet;
  List<Transaction>? transactionList;

  DashboardPageStates(
      {this.activeCategory = 'expense',
      this.totalAmountWallet = 0,
      this.transactionList});

  DashboardPageStates copyWith(
      {String? activeCategory,
      int? totalAmountWallet,
      List<Transaction>? transactionList}) {
    return DashboardPageStates(
      activeCategory: activeCategory ?? this.activeCategory,
      totalAmountWallet: totalAmountWallet ?? this.totalAmountWallet,
      transactionList: transactionList ?? this.transactionList,
    );
  }
}
