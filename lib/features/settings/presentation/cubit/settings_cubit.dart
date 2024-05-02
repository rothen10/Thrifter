// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/core/use_case/use_case.dart';
import 'package:thrifter/features/category/domain/use_case/category_use_case.dart';
import 'package:thrifter/features/settings/domain/use_case/setting_use_case.dart';
import 'package:thrifter/features/transaction/domain/use_case/transaction_use_case.dart';

part 'settings_state.dart';

@injectable
class SettingCubit extends Cubit<SettingsState> {
  SettingCubit(
    this.transactionsUseCase,
    this.getDefaultCategoriesUseCase,
    this.updateExpensesUseCase,
    this.jsonFileImportUseCase,
    this.jsonFileExportUseCase,
    this.settingsUseCase,
    this.csvFileExportUseCase,
  ) : super(SettingsInitial());

  final CSVFileExportUseCase csvFileExportUseCase;
  final GetDefaultCategoriesUseCase getDefaultCategoriesUseCase;
  final JSONFileExportUseCase jsonFileExportUseCase;
  final JSONFileImportUseCase jsonFileImportUseCase;
  final SettingsUseCase settingsUseCase;
  final GetTransactionsUseCase transactionsUseCase;
  final UpdateTransactionUseCase updateExpensesUseCase;

  void shareFile() {
    jsonFileExportUseCase(NoParams()).then((fileExport) {
      fileExport.fold(
        (failure) => emit(ImportFileError(mapFailureToMessage(failure))),
        (path) => Share.shareXFiles(
          [XFile(path)],
          subject: 'Share',
        ),
      );
    });
  }

  void shareCSVFile() {
    csvFileExportUseCase().then((fileExport) => fileExport.fold(
          (failure) => emit(ImportFileError(mapFailureToMessage(failure))),
          (path) => Share.shareXFiles(
            [XFile(path)],
            subject: 'Share',
          ),
        ));
  }

  void importDataFromJson() {
    emit(ImportFileLoading());
    jsonFileImportUseCase().then((fileImport) => fileImport.fold(
          (failure) => emit(ImportFileError(mapFailureToMessage(failure))),
          (r) => emit(ImportFileSuccessState()),
        ));
  }

  int? get defaultAccountId => settingsUseCase.get(defaultAccountIdKey);

  dynamic setDefaultAccountId(int accountId) =>
      settingsUseCase.put(defaultAccountIdKey, accountId);

  void setDefaultCalendarFormat(String format) =>
      settingsUseCase.put(calendarFormatKey, format);
}
