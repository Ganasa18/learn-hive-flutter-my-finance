import 'package:hive/hive.dart';
part 'wallet_model.g.dart';

@HiveType(typeId: 2)
class Wallet extends HiveObject {
  @HiveField(1)
  String nameWallet;
  @HiveField(2)
  int amountWallet;

  Wallet({
    required this.nameWallet,
    required this.amountWallet,
  });
}
