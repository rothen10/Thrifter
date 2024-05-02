import 'package:thrifter/features/goals/data/models/goal_model.dart';
import 'package:thrifter/features/goals/domain/entity/goal_entity.dart';

extension GoalHelper on GoalModel {
  GoalEntity toEntity() {
    return GoalEntity(
      icon: icon,
      name: name,
      amount: amount,
      superId: superId,
    );
  }
}

extension GoalListHelper on Iterable<GoalModel> {
  Iterable<GoalEntity> toEntities() {
    return map((e) => e.toEntity());
  }
}
