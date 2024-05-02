// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/features/settings/domain/repository/import_export.dart';
import 'package:thrifter/features/settings/domain/repository/settings_repository.dart';

@lazySingleton
class JSONFileImportUseCase {
  JSONFileImportUseCase(
    this.settingsRepository,
    @Named('json_import') this.jsonImport,
  );

  final Import jsonImport;
  final SettingsRepository settingsRepository;

  Future<Either<Failure, bool>> call() =>
      settingsRepository.importFileToData(import: jsonImport);
}
