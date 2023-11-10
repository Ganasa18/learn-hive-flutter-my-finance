import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class Transaction extends HiveObject {
  @HiveField(1)
  String nameCategory;
  @HiveField(2)
  int iconCategory;
  @HiveField(3)
  int amountTransaction;
  @HiveField(4)
  int amountTransactionOld;
  @HiveField(5)
  String typeTransaction;
  @HiveField(6)
  String walletType;
  @HiveField(7)
  DateTime dateCreated;

  Transaction({
    required this.nameCategory,
    required this.iconCategory,
    required this.amountTransaction,
    required this.amountTransactionOld,
    required this.typeTransaction,
    required this.dateCreated,
    required this.walletType,
  });

  Transaction copyWith({
    int? idTransaction,
    String? nameCategory,
    int? iconCategory,
    int? amountTransaction,
    int? amountTransactionOld,
    String? typeTransaction,
    String? walletType,
    DateTime? dateCreated,
  }) {
    return Transaction(
      nameCategory: nameCategory ?? this.nameCategory,
      iconCategory: iconCategory ?? this.iconCategory,
      amountTransaction: amountTransaction ?? this.amountTransaction,
      amountTransactionOld: amountTransactionOld ?? this.amountTransactionOld,
      typeTransaction: typeTransaction ?? this.typeTransaction,
      walletType: walletType ?? this.walletType,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameCategory': nameCategory,
      'iconCategory': iconCategory,
      'amountTransaction': amountTransaction,
      'amountTransactionOld': amountTransactionOld,
      'typeTransaction': typeTransaction,
      'walletType': walletType,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  // Add a factory constructor to create a Transaction object from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      nameCategory: json['nameCategory'],
      iconCategory: json['iconCategory'],
      amountTransaction: json['amountTransaction'],
      amountTransactionOld: json['amountTransactionOld'],
      typeTransaction: json['typeTransaction'],
      walletType: json['walletType'],
      dateCreated: DateTime.parse(json['dateCreated']),
    );
  }
}
