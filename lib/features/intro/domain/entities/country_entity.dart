// ignore_for_file: invalid_annotation_target

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_entity.freezed.dart';
part 'country_entity.g.dart';

@freezed
class CountryEntity with _$CountryEntity {
  factory CountryEntity({
    required String code,
    int? decimalDigits,
    String? decimalSeparator,
    required String name,
    String? namePlural,
    required int number,
    required String pattern,
    bool? spaceBetweenAmountAndSymbol,
    String? symbol,
    bool? symbolOnLeft,
    required String thousandsSeparator,
  }) = _CountryEntity;

  factory CountryEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryEntityFromJson(json);
}
