// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/error/exceptions.dart';
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/features/settings/domain/repository/import_export.dart';
import 'package:thrifter/features/settings/domain/repository/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(
    @Named('settings') this.settings,
  );

  final Box<dynamic> settings;

  @override
  Future<void> delete(String key) => settings.delete(key);

  @override
  T get<T>(String key, {dynamic defaultValue}) =>
      settings.get(key, defaultValue: defaultValue);

  @override
  Future<Either<Failure, bool>> importFileToData({
    required Import import,
  }) async {
    try {
      final bool result = await import.import();
      return right(result);
    } on FileNotFoundException {
      return left(FileNotFoundFailure());
    } on ErrorFileException {
      return left(ErrorFileExportFailure());
    }
  }

  @override
  Future<void> put(String key, value) => settings.put(key, value);

  @override
  Future<Either<Failure, String>> exportDataToFile(
      {required Export export}) async {
    try {
      final String path = await export.export();
      if (path.isEmpty) {
        return left(FileNotFoundFailure());
      } else {
        return right(path);
      }
    } catch (err) {
      print(err);
      return left(ErrorFileExportFailure());
    }
  }
}
