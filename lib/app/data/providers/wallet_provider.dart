import 'package:my_finance_apps/app/data/models/wallet_model.dart';
import 'package:my_finance_apps/app/data/services/wallet_service.dart';

class WalletProvider {
  WalletStorageService walletStorageService;
  WalletProvider(this.walletStorageService);

  Future<void> createWallet(Wallet wallet) {
    return walletStorageService.createWallet(wallet);
  }

  Future<List<Wallet?>> readWallet() {
    return walletStorageService.readWallet();
  }

  Future<void> updateWalletAmount(Wallet wallet, String type) async {
    return walletStorageService.updateWalletAmount(wallet, type);
  }
}
