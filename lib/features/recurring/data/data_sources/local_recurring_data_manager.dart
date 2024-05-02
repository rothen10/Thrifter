// Project imports:
import 'package:thrifter/features/recurring/data/model/recurring.dart';

abstract class LocalRecurringDataManager {
  Future<void> addRecurringEvent(RecurringModel recurringModel);

  List<RecurringModel> recurringModels();

  Future<void> clearRecurring(int recurringId);
}
