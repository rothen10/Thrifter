// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/settings/domain/repository/import_export.dart';
import 'package:thrifter/features/settings/domain/repository/settings_repository.dart';

@lazySingleton
class JSONFileExportUseCase
    implements UseCase<Future<Either<Failure, String>>, NoParams> {
  JSONFileExportUseCase(
    this.settingsRepository,
    @Named('json_export') this.jsonExport,
  );

  final Export jsonExport;
  final SettingsRepository settingsRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      settingsRepository.exportDataToFile(export: jsonExport);
}
