// Package imports:
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/features/recurring/data/model/recurring.dart';
import 'package:thrifter/features/recurring/data/data_sources/local_recurring_data_manager.dart';

@Injectable(as: LocalRecurringDataManager)
class LocalRecurringDataManagerImpl implements LocalRecurringDataManager {
  LocalRecurringDataManagerImpl(this.recurringBox);

  final Box<RecurringModel> recurringBox;

  @override
  Future<void> addRecurringEvent(RecurringModel recurringModel) async {
    final id = await recurringBox.add(recurringModel);
    recurringModel.superId = id;
    return recurringModel.save();
  }

  @override
  Future<void> clearRecurring(int key) {
    return recurringBox.delete(key);
  }

  @override
  List<RecurringModel> recurringModels() {
    return recurringBox.values.toList();
  }
}
