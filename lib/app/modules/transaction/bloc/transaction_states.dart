import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';

class TransactionStates {
  String typeTransaction;
  int amount;
  int chipIndex;
  List<Category>? categories;
  Category? category;
  Wallet? wallet;
  TransactionStates({
    this.typeTransaction = 'expense',
    this.amount = 0,
    this.categories,
    this.chipIndex = 0,
    this.category,
    this.wallet,
  });

  TransactionStates copyWith({
    String? typeTransaction,
    int? amount,
    List<Category>? categories,
    int? chipIndex,
    Category? category,
    Wallet? wallet,
  }) {
    return TransactionStates(
      typeTransaction: typeTransaction ?? this.typeTransaction,
      amount: amount ?? this.amount,
      categories: categories ?? this.categories,
      chipIndex: chipIndex ?? this.chipIndex,
      category: category ?? this.category,
      wallet: wallet ?? this.wallet,
    );
  }
}
