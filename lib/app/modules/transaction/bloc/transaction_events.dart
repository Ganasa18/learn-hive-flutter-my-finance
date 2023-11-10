import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';

class TransactionEvents extends Equatable {
  const TransactionEvents();
  @override
  List<Object?> get props => [];
}

class SelectedTransactionType extends TransactionEvents {
  final String typeTransaction;
  const SelectedTransactionType(this.typeTransaction);

  @override
  List<Object?> get props => [typeTransaction];
}

class SetAmountTransaction extends TransactionEvents {
  final int amount;
  const SetAmountTransaction(this.amount);

  @override
  List<Object?> get props => [amount];
}

class SetCategoryTransaction extends TransactionEvents {
  final List<Category> categories;
  const SetCategoryTransaction(this.categories);

  @override
  List<Object?> get props => [categories];
}

class SetSelectedIcon extends TransactionEvents {
  final int chipIndex;
  const SetSelectedIcon(this.chipIndex);
  @override
  List<Object?> get props => [chipIndex];
}

class SetFormCreateCategory extends TransactionEvents {
  final Category category;
  const SetFormCreateCategory(this.category);
  @override
  List<Object?> get props => [category];
}

class SetSelectedWallet extends TransactionEvents {
  final Wallet wallet;

  const SetSelectedWallet(this.wallet);
  @override
  List<Object?> get props => [wallet];
}

class SetSelectedCategory extends TransactionEvents {
  final Category category;
  const SetSelectedCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class ResetTransaction extends TransactionEvents {}
