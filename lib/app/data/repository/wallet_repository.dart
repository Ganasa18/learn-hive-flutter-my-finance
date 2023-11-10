import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/data/providers/wallet_provider.dart';

class WalletRepository {
  WalletProvider walletProvider;
  WalletRepository(this.walletProvider);

  Future<void> createWallet(Wallet wallet) {
    return walletProvider.createWallet(wallet);
  }

  Future<List<Wallet?>> readWallet() {
    return Future.delayed(const Duration(seconds: 1), () {
      return walletProvider.readWallet();
    });
  }

  Future<void> updateWalletAmount(Wallet wallet, String type) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return walletProvider.updateWalletAmount(wallet, type);
    });
  }
}
