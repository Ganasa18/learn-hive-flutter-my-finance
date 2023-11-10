import 'package:hive/hive.dart';
import 'package:my_finance_apps/app/core/values/keys.dart';
import 'package:my_finance_apps/app/data/models/wallet_model.dart';

class WalletStorageService {
  late Box<Wallet> _walletBox;

  List<dynamic> walletList = [];

  Future<void> init() async {
    try {
      // Initialize Hive and open the box for category
      if (!Hive.isAdapterRegistered(WalletAdapter().typeId)) {
        // If it's not registered, then register the adapter
        Hive.registerAdapter(WalletAdapter());
      }
      _walletBox = await Hive.openBox<Wallet>(walletKey);
    } catch (e) {
      // Handle errors, such as Hive initialization or box opening failure.
      // ignore: avoid_print
      print('Error initializing user storage: $e');
    }
  }

  Future<void> createWallet(Wallet wallet) async {
    await _walletBox.add(wallet);
  }

  Future<List<Wallet>> readWallet() async {
    final walletList = _walletBox.values.toList();
    return walletList;
  }

  Future<void> updateWalletAmount(Wallet wallet, String type) async {
    final walletToUpdate = _walletBox.values.firstWhere(
        (element) => element.nameWallet == wallet.nameWallet,
        orElse: () => Wallet(nameWallet: '', amountWallet: 0));
    if (walletToUpdate.nameWallet != '') {
      if (type == 'expense') {
        int valueUpdate = walletToUpdate.amountWallet - wallet.amountWallet;
        walletToUpdate.amountWallet = valueUpdate;
      } else {
        int valueUpdate = walletToUpdate.amountWallet + wallet.amountWallet;
        walletToUpdate.amountWallet = valueUpdate;
      }
      await _walletBox.put(walletToUpdate.key, walletToUpdate);
    } else {
      print('Wallet not found in the Hive box.');
    }
    await _walletBox.close();
  }
}
