// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/intro/domain/entities/country_entity.dart';
import 'package:thrifter/features/intro/domain/repository/country_repository.dart';

@lazySingleton
class GetSelectedCountryUseCase implements UseCase<CountryEntity?, NoParams> {
  final CountryRepository repository;

  GetSelectedCountryUseCase({required this.repository});
  @override
  CountryEntity? call(NoParams params) {
    return repository.fetchSelectedCountry();
  }
}
