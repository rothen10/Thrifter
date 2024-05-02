// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/common_enum.dart';
import 'package:thrifter/features/recurring/domain/repository/recurring_repository.dart';

@lazySingleton
class AddRecurringUseCase {
  AddRecurringUseCase(this.repository);

  final RecurringRepository repository;

  Future<void> call(
    String name,
    double amount,
    DateTime recurringTime,
    RecurringType recurringType,
    int selectedAccountId,
    int selectedCategoryId,
    TransactionType transactionType,
  ) {
    return repository.addRecurringEvent(
      name,
      amount,
      recurringTime,
      recurringType,
      selectedAccountId,
      selectedCategoryId,
      transactionType,
    );
  }
}
