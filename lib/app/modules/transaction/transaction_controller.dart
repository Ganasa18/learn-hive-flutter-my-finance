import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/common/routes/names.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/category_model.dart';
import 'package:my_finance_apps/app/data/models/transaction_model.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/data/providers/category_provider.dart';
import 'package:my_finance_apps/app/data/providers/transaction_provider.dart';
import 'package:my_finance_apps/app/data/providers/wallet_provider.dart';
import 'package:my_finance_apps/app/data/repository/category_repository.dart';
import 'package:my_finance_apps/app/data/repository/transaction_repository.dart';
import 'package:my_finance_apps/app/data/repository/wallet_repository.dart';
import 'package:my_finance_apps/app/data/services/category_service.dart';
import 'package:my_finance_apps/app/data/services/transaction_service.dart';
import 'package:my_finance_apps/app/data/services/wallet_service.dart';
import 'package:my_finance_apps/app/modules/dashboard/dashboard_controller.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_blocs.dart';
import 'package:my_finance_apps/app/modules/transaction/bloc/transaction_events.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:my_finance_apps/app/modules/wallet/wallet_controller.dart';

class TransactionController {
  late BuildContext context;

  static final TransactionController _singleton = TransactionController._();
  TransactionController._();

// make sure you have the original only one instance
  factory TransactionController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  createCategory(Category category) async {
    final categoryStorageService = CategoryStorageService();
    await categoryStorageService.init();
    CategoryProvider categoryProvider =
        CategoryProvider(categoryStorageService);
    CategoryRepository categoryRepository =
        CategoryRepository(categoryProvider);
    // print('Category Object:');
    // print('idCategory: ${category.idCategory}');
    // print('nameCategory: ${category.nameCategory}');
    // print('iconCategory: ${category.iconCategory}');
    // CREATE CATEGORY
    final categoryBox = await Hive.openBox<Category>(categoryKey);
    final existingCategory = categoryBox.values.firstWhere(
      (existing) => existing.nameCategory == category.nameCategory,
      orElse: () => Category(idCategory: 0, nameCategory: '', iconCategory: 0),
    );
    if (existingCategory.nameCategory == category.nameCategory) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Message',
          message: "Category with the same name already exists.",
          contentType: ContentType.warning,
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(snackBar);
        return;
      }
    } else {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      await categoryRepository.createCategory(category);
    }

    Future.delayed(const Duration(seconds: 2), () async {
      await initializeData();
      if (context.mounted) {
        EasyLoading.dismiss();
        Navigator.pop(context);
      }
    });
  }

  resetValueTransaction() {
    context.read<TransactionBloc>().add(ResetTransaction());
  }

  Future<void> initializeData() async {
    try {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      final categoryStorageService = CategoryStorageService();
      await categoryStorageService.init();
      CategoryProvider categoryProvider =
          CategoryProvider(categoryStorageService);

      CategoryRepository categoryRepository =
          CategoryRepository(categoryProvider);

      List<Category?> categories = await categoryRepository.readCategories();

      if (categories.isNotEmpty) {
        List<Category> nonNullableCategories = categories
            .where((category) => category != null)
            .map((category) => category!)
            .toList();
        if (context.mounted) {
          context
              .read<TransactionBloc>()
              .add(SetCategoryTransaction(nonNullableCategories));
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

  Future<void> createTransaction(Transaction transaction) async {
    try {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      // TRANSACTION SERVICE
      final transactionStorageService = TransactionStorageService();
      await transactionStorageService.init();
      TransactionProvider transactionProvider =
          TransactionProvider(transactionStorageService);
      TransactionRepository transactionRepository =
          TransactionRepository(transactionProvider);

      // WALLET SERVICE
      final walletStorageService = WalletStorageService();
      await walletStorageService.init();
      WalletProvider walletProvider = WalletProvider(walletStorageService);
      WalletRepository walletRepository = WalletRepository(walletProvider);

      Wallet wallet = Wallet(
          nameWallet: transaction.walletType,
          amountWallet: transaction.amountTransaction);

      transactionRepository.createTransaction(transaction);
      walletRepository.updateWalletAmount(wallet, transaction.typeTransaction);

      Future.delayed(const Duration(seconds: 2), () async {
        resetValueTransaction();
        EasyLoading.dismiss();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
      });
    } catch (error) {
      // ignore: avoid_print
      print('Error reading categories: $error');
      EasyLoading.dismiss();
    }
  }
}
