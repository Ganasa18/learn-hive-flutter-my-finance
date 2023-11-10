import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/data/providers/transaction_provider.dart';
import 'package:my_finance_apps/app/data/providers/wallet_provider.dart';
import 'package:my_finance_apps/app/data/repository/transaction_repository.dart';
import 'package:my_finance_apps/app/data/repository/wallet_repository.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';
import 'package:my_finance_apps/app/data/services/wallet_service.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_blocs.dart';
import 'package:my_finance_apps/app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_blocs.dart';
import 'package:my_finance_apps/app/modules/wallet/bloc/wallet_event.dart';

class WalletController {
  late BuildContext context;
  static final WalletController _singleton = WalletController._();
  WalletController._();

// make sure you have the original only one instance
  factory WalletController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  createWallet(Wallet wallet) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    final walletStorageService = WalletStorageService();
    await walletStorageService.init();
    WalletProvider walletProvider = WalletProvider(walletStorageService);

    WalletRepository walletRepository = WalletRepository(walletProvider);

    // print('Wallet Object:');
    // print('idWallet: ${wallet.idWallet}');
    // print('nameWallet: ${wallet.nameWallet}');
    // print('amount: ${wallet.amountWallet}');

    await walletRepository.createWallet(wallet);
    Future.delayed(const Duration(seconds: 2), () async {
      await initializeDataWallet();
      if (context.mounted) {
        EasyLoading.dismiss();
        Navigator.pop(context);
      }
    });
  }

  Future<void> initializeDataWallet() async {
    try {
      final walletStorageService = WalletStorageService();
      await walletStorageService.init();
      WalletProvider walletProvider = WalletProvider(walletStorageService);

      WalletRepository walletRepository = WalletRepository(walletProvider);
      List<Wallet?> wallets = await walletRepository.readWallet();

      if (wallets.isNotEmpty) {
        List<Wallet> nonNullableWallets = wallets
            .where((wallet) => wallet != null)
            .map((wallet) => wallet!)
            .toList();

        int totalAmount = wallets
            .where((wallet) => wallet != null)
            .map((wallet) => wallet!.amountWallet)
            .fold(0, (int previousValue, int amount) => previousValue + amount);

        // print("$totalAmount UPDATE AMOUNT WALLET");
        if (context.mounted) {
          context.read<WalletBloc>().add(SetWalletList(nonNullableWallets));
          context
              .read<DashboardPageBloc>()
              .add(SetTotalAmountWallet(totalAmount));
          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.dismiss();
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error reading categories: $error');
      EasyLoading.dismiss();
    }
  }

  Future<void> initializeWalletDetail(String typeWallet) async {
    try {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      final transactionService = TransactionStorageService();
      await transactionService.init();

      TransactionProvider transactionProvider =
          TransactionProvider(transactionService);

      TransactionRepository transactionRepository =
          TransactionRepository(transactionProvider);

      final resultOut = await transactionRepository.readGroupedTransactions(
          "expense", typeWallet);
      final resultIn = await transactionRepository.readGroupedTransactions(
          "income", typeWallet);
      final totalExpense = await transactionRepository
          .countTotalTransactionCard("expense", typeWallet);
      final totalIncome = await transactionRepository.countTotalTransactionCard(
          "income", typeWallet);

      // // Convert the list to a JSON string for debugging
      // print("${json.encode(resultOut)}======================== RESULT OUT");
      // print(
      //     "============================================================= \br\br");
      // print("${json.encode(resultIn)}======================== RESULT IN");

      if (context.mounted) {
        context.read<WalletBloc>().add(SetWalletTransactionExpense(resultOut));
        context.read<WalletBloc>().add(SetWalletTransactionIncome(resultIn));
        context
            .read<WalletBloc>()
            .add(SetCountTotalAmountCard(totalExpense, totalIncome));
        EasyLoading.dismiss();
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error reading categories: $error');
      EasyLoading.dismiss();
    }

    // // Convert the list to a JSON string for debugging
    // print("${json.encode(resultOut)}======================== RESULT OUT");
    // print(
    //     "============================================================= \br\br");
    // print("${json.encode(resultIn)}======================== RESULT IN");
  }
}
