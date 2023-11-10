import 'package:my_finance_apps/app/data/models/transaction_model.dart';

class WalletDetail {
  final String date;
  final List<Transaction> transactionList;
  WalletDetail({
    required this.date,
    required this.transactionList,
  });
}
