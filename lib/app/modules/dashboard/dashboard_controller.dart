import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/providers/transaction_provider.dart';
import 'package:my_finance_apps/app/data/repository/transaction_repository.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_events.dart';

class DashboardController {
  late BuildContext context;

  static final DashboardController _singleton = DashboardController._();
  DashboardController._();

  factory DashboardController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  getListTransaction(String typeTransaction) async {
    final transactionStorageService = TransactionStorageService();
    await transactionStorageService.init();
    TransactionProvider transactionProvider =
        TransactionProvider(transactionStorageService);
    TransactionRepository transactionRepository =
        TransactionRepository(transactionProvider);

    List<Transaction?> transactionList =
        await transactionRepository.readTransactions(typeTransaction);

    if (transactionList.isNotEmpty) {
      List<Transaction> nonNullableTransactionList = transactionList
          .where((transaction) => transaction != null)
          .map((transaction) => transaction!)
          .toList();

      if (context.mounted) {
        context
            .read<DashboardPageBloc>()
            .add(SetTransactionList(nonNullableTransactionList));
      }
    } else {
      if (context.mounted) {
        context
            .read<DashboardPageBloc>()
            .add(const SetTransactionList(<Transaction>[]));
      }
    }
  }
}
