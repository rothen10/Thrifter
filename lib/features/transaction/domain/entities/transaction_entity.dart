// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:thrifter/core/common_enum.dart';

part 'transaction_entity.freezed.dart';

@freezed
class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required int accountId,
    required int categoryId,
    required double currency,
    String? description,
    required String name,
    int? superId,
    required DateTime time,
    @Default(TransactionType.expense) TransactionType type,
  }) = _TransactionEntity;
}
