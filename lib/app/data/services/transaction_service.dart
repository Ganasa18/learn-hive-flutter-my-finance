import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/models/wallet_detail_model.dart';

class TransactionStorageService {
  late Box<Transaction> _transactionBox;
  List<dynamic> transactionList = [];

  Future<void> init() async {
    try {
      // Initialize Hive and open the box for category
      if (!Hive.isAdapterRegistered(TransactionAdapter().typeId)) {
        // If it's not registered, then register the adapter
        Hive.registerAdapter(TransactionAdapter());
      }
      _transactionBox = await Hive.openBox<Transaction>(transactionKey);
    } catch (e) {
      // Handle errors, such as Hive initialization or box opening failure.
      // ignore: avoid_print
      print('Error initializing user storage: $e');
    }
  }

  Future<void> createTransaction(Transaction transaction) async {
    await _transactionBox.add(transaction);
  }

  Future<List<Transaction>> readTransactions(String typeTransaction) async {
    final transactionList = _transactionBox.values
        .where((element) => element.typeTransaction == typeTransaction)
        .toList()
        .reversed
        .toList();

    if (transactionList.isEmpty) {
      return <Transaction>[];
    }

    return transactionList;
  }

  Future<List<Map<String, dynamic>>> readGroupedTransactions(
      String typeTransaction, String cardType) async {
    final transactionList = _transactionBox.values
        .where((element) =>
            element.typeTransaction == typeTransaction &&
            element.walletType == cardType)
        .toList();

    if (transactionList.isEmpty) {
      return <Map<String, List<Transaction>>>[];
    }
    final groupedTransactions =
        groupTransactionsByDate(transactionList, typeTransaction, cardType);

    // print(
    //     "${json.encode(groupedTransactions)}======================== RESULT OUT");

    return groupedTransactions;
  }

  Future<int> countTotalTransactionCard(
      String typeTransaction, String cardType) async {
    final transactionList = _transactionBox.values
        .where((element) =>
            element.typeTransaction == typeTransaction &&
            element.walletType == cardType)
        .toList();

    int totalAmount = transactionList.fold(0, (int accumulator, element) {
      return accumulator + element.amountTransaction;
    });
    return totalAmount;
  }

  Future<List<double>> countTotalTransactionPercentage() async {
    final transactionList = _transactionBox.values.toList();

    // Calculate total income and total expense separately
    int totalIncome = transactionList
        .where((element) => element.typeTransaction == "income")
        .fold(0, (int accumulator, element) {
      return accumulator + element.amountTransaction;
    });

    int totalExpense = transactionList
        .where((element) => element.typeTransaction == "expense")
        .fold(0, (int accumulator, element) {
      return accumulator + element.amountTransaction;
    });

    int totalAll = transactionList.fold(0, (int accumulator, element) {
      return accumulator + element.amountTransaction;
    });

    List<double> percentages = [
      (totalExpense / totalAll) * 100, // Percentage of total expense
      (totalIncome / totalAll) * 100 // Percentage of total income
    ];

    // print("$totalExpense TOTAL EXPENSE");
    // print("$totalIncome TOTAL INCOME");
    // print("$totalAll TOTAL INCOME");

    // List<double> percentages = transactionList.map((element) {
    //   double percentage = 0.0;

    //   if (element.typeTransaction == "income") {
    //     percentage = (element.amountTransaction / totalIncome) * 100;
    //   } else if (element.typeTransaction == "expense") {
    //     percentage = (element.amountTransaction / totalExpense) * 100;
    //   }

    //   return percentage;
    // }).toList();

    // print("${percentages.toList()} RETURN VALUE PERCENTAGE");

    return percentages;
  }

  List<Map<String, dynamic>> groupTransactionsByDate(
      List<Transaction> transactions,
      String typeTransaction,
      String walletType) {
    final remappedTransactions = transactions
        .where((element) =>
            element.typeTransaction == typeTransaction &&
            element.walletType == walletType)
        .map((transaction) {
      // Format the date as "yyyy-MM-dd"
      final dateCreated =
          transaction.dateCreated.toLocal().toIso8601String().substring(0, 10);
      return {
        "nameCategory": transaction.nameCategory,
        "iconCategory": transaction.iconCategory,
        "amountTransaction": transaction.amountTransaction,
        "amountTransactionOld": transaction.amountTransactionOld,
        "typeTransaction": transaction.typeTransaction,
        "walletType": transaction.walletType,
        "dateCreated": dateCreated,
      };
    }).toList();

    final groupedTransactions = groupBy(remappedTransactions, (transaction) {
      return transaction['dateCreated'];
    });

    final result = groupedTransactions.entries.map((entry) {
      final date = entry.key;
      final transactionList = entry.value.toList();
      return {
        "dateCreated": date,
        "transaction": transactionList,
      };
    }).toList();

    return result;
  }
}
