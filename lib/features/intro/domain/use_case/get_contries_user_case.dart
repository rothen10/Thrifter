// Package imports:
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/intro/domain/entities/country_entity.dart';
import 'package:thrifter/features/intro/domain/repository/country_repository.dart';

@injectable
class GetCountriesUseCase implements UseCase<List<CountryEntity>, NoParams> {
  GetCountriesUseCase({required this.repository});

  final CountryRepository repository;

  @override
  List<CountryEntity> call(NoParams params) {
    return repository
        .fetchCountries()
        .sorted((a, b) => a.name.compareTo(b.name));
  }
}
