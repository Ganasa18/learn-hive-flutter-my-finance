import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/providers/transaction_provider.dart';

class TransactionRepository {
  TransactionProvider transactionProvider;
  TransactionRepository(this.transactionProvider);

  Future<void> createTransaction(Transaction transaction) {
    return transactionProvider.createTransaction(transaction);
  }

  Future<List<Transaction?>> readTransactions(String typeTransaction) {
    return Future.delayed(const Duration(seconds: 1), () {
      return transactionProvider.readTransactions(typeTransaction);
    });
  }

  Future<List<Map<String, dynamic>>> readGroupedTransactions(
      String typeTransaction, String cardType) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return transactionProvider.readGroupedTransactions(
          typeTransaction, cardType);
    });
  }

  Future<int> countTotalTransactionCard(
      String typeTransaction, String cardType) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return transactionProvider.countTotalTransactionCard(
          typeTransaction, cardType);
    });
  }

  Future<List<double>> countTotalTransactionPercentage() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return transactionProvider.countTotalTransactionPercentage();
    });
  }
}
