// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/features/settings/domain/repository/import_export.dart';
import 'package:thrifter/features/settings/domain/repository/settings_repository.dart';

@lazySingleton
class CSVFileExportUseCase {
  CSVFileExportUseCase(
    this.settingsRepository,
    @Named('csv') this.csvExport,
  );
  final Export csvExport;
  final SettingsRepository settingsRepository;

  Future<Either<Failure, String>> call() =>
      settingsRepository.exportDataToFile(export: csvExport);
}
