// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/intro/data/data_source/local_country_data.dart';
import 'package:thrifter/features/intro/data/models/country_model.dart';
import 'package:thrifter/features/intro/domain/entities/country_entity.dart';
import 'package:thrifter/features/intro/domain/repository/country_repository.dart';

@LazySingleton(as: CountryRepository)
class CountryRepositoryImpl implements CountryRepository {
  CountryRepositoryImpl(
    @Named('settings') this.settings,
  );

  final Box<dynamic> settings;

  @override
  List<CountryEntity> fetchCountries() {
    return List<CountryEntity>.from(
        localCountriesData.map((x) => CountryModel.fromJson(x).toEntity()));
  }

  @override
  CountryEntity? fetchSelectedCountry() {
    try {
      final Map<dynamic, dynamic>? json = settings.get(userCountryKey);
      if (json == null) {
        return null;
      }
      final Map<String, dynamic> map =
          json.map<String, dynamic>((key, value) => MapEntry(key, value));
      final CountryModel model = CountryModel.fromJson(map);
      return model.toEntity();
    } catch (er) {
      return null;
    }
  }

  @override
  Future<void> saveSelectedCountry(CountryEntity entity) {
    final CountryModel model = entity.toModel();
    return settings.put(userCountryKey, model.toJson());
  }
}
