import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';

class TransactionProvider {
  TransactionStorageService transactionStorageService;
  TransactionProvider(this.transactionStorageService);

  Future<void> createTransaction(Transaction transaction) {
    return transactionStorageService.createTransaction(transaction);
  }

  Future<List<Transaction?>> readTransactions(String typeTransaction) {
    return transactionStorageService.readTransactions(typeTransaction);
  }

  Future<List<Map<String, dynamic>>> readGroupedTransactions(
      String typeTransaction, String cardType) async {
    return transactionStorageService.readGroupedTransactions(
        typeTransaction, cardType);
  }

  Future<int> countTotalTransactionCard(
      String typeTransaction, String cardType) async {
    return transactionStorageService.countTotalTransactionCard(
        typeTransaction, cardType);
  }

  Future<List<double>> countTotalTransactionPercentage() async {
    return transactionStorageService.countTotalTransactionPercentage();
  }
}
