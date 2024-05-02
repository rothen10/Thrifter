// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<_$TransactionModelImpl> {
  @override
  final int typeId = 0;

  @override
  _$TransactionModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TransactionModelImpl(
      accountId: fields[5] as int,
      categoryId: fields[6] as int,
      currency: fields[1] as double,
      description: fields[8] as String?,
      name: fields[0] as String,
      superId: fields[7] as int?,
      time: fields[3] as DateTime,
      type: fields[4] as TransactionType,
    );
  }

  @override
  void write(BinaryWriter writer, _$TransactionModelImpl obj) {
    writer
      ..writeByte(8)
      ..writeByte(5)
      ..write(obj.accountId)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.superId)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      accountId: json['accountId'] as int,
      categoryId: json['categoryId'] as int,
      currency: (json['currency'] as num?)?.toDouble() ?? 0,
      description: json['description'] as String?,
      name: json['name'] as String,
      superId: json['superId'] as int?,
      time: DateTime.parse(json['time'] as String),
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
          TransactionType.expense,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'categoryId': instance.categoryId,
      'currency': instance.currency,
      'description': instance.description,
      'name': instance.name,
      'superId': instance.superId,
      'time': instance.time.toIso8601String(),
      'type': _$TransactionTypeEnumMap[instance.type]!,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.expense: 'expense',
  TransactionType.income: 'income',
  TransactionType.transfer: 'transfer',
};
