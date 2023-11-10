import 'package:equatable/equatable.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';

class DashboardPageEvents extends Equatable {
  const DashboardPageEvents();
  @override
  List<Object?> get props => [];
}

class CategoryActiveIndex extends DashboardPageEvents {
  final String categoryActive;
  const CategoryActiveIndex(this.categoryActive);
  @override
  List<Object?> get props => [categoryActive];
}

class SetTotalAmountWallet extends DashboardPageEvents {
  final int totalAmountWallet;
  const SetTotalAmountWallet(this.totalAmountWallet);
  @override
  List<Object?> get props => [totalAmountWallet];
}

class SetTransactionList extends DashboardPageEvents {
  final List<Transaction> transactionList;
  const SetTransactionList(this.transactionList);

  @override
  List<Object?> get props => [transactionList];
}
