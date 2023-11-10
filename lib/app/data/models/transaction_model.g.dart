// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 3;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      nameCategory: fields[1] as String,
      iconCategory: fields[2] as int,
      amountTransaction: fields[3] as int,
      amountTransactionOld: fields[4] as int,
      typeTransaction: fields[5] as String,
      dateCreated: fields[7] as DateTime,
      walletType: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.nameCategory)
      ..writeByte(2)
      ..write(obj.iconCategory)
      ..writeByte(3)
      ..write(obj.amountTransaction)
      ..writeByte(4)
      ..write(obj.amountTransactionOld)
      ..writeByte(5)
      ..write(obj.typeTransaction)
      ..writeByte(6)
      ..write(obj.walletType)
      ..writeByte(7)
      ..write(obj.dateCreated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
