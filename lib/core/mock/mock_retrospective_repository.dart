import '../models/retrospective.dart';
import '../models/retrospective_draft.dart';
import '../models/sprint.dart';
import '../repositories/retrospective_repository.dart';
import '../../shared/utils/id_generator.dart';
import 'mock_store.dart';

class MockRetrospectiveRepository implements RetrospectiveRepository {
  MockRetrospectiveRepository(this._store);

  final MockStore _store;

  @override
  Retrospective? fetchBySprintId(String sprintId) {
    for (final retrospective in _store.retrospectives) {
      if (retrospective.sprintId == sprintId) {
        return retrospective;
      }
    }
    return null;
  }

  @override
  List<Retrospective> fetchRetrospectives() {
    return List<Retrospective>.from(_store.retrospectives)
      ..sort((left, right) => right.createdAt.compareTo(left.createdAt));
  }

  @override
  RetrospectiveSaveResult saveRetrospective(RetrospectiveDraft draft) {
    final existingIndex = _store.retrospectives.indexWhere(
      (retrospective) => retrospective.sprintId == draft.sprintId,
    );

    final retrospective = Retrospective(
      id: existingIndex == -1
          ? IdGenerator.next('retrospective')
          : _store.retrospectives[existingIndex].id,
      goalId: draft.goalId,
      sprintId: draft.sprintId,
      wentWell: draft.wentWell,
      challenges: draft.challenges,
      keepDoing: draft.keepDoing,
      changeNext: draft.changeNext,
      createdAt: DateTime.now(),
    );

    if (existingIndex == -1) {
      _store.retrospectives = [retrospective, ..._store.retrospectives];
    } else {
      _store.retrospectives[existingIndex] = retrospective;
    }

    for (var goalIndex = 0; goalIndex < _store.goals.length; goalIndex++) {
      final goal = _store.goals[goalIndex];

      for (var sprintIndex = 0;
          sprintIndex < goal.sprints.length;
          sprintIndex++) {
        final sprint = goal.sprints[sprintIndex];
        if (sprint.id != draft.sprintId) {
          continue;
        }

        final updatedSprints = List<Sprint>.from(goal.sprints);
        updatedSprints[sprintIndex] = sprint.copyWith(
          retrospectiveCompleted: true,
        );
        _store.goals[goalIndex] = goal.copyWith(sprints: updatedSprints);
        break;
      }
    }

    return RetrospectiveSaveResult(
      retrospective: retrospective,
      wasCreated: existingIndex == -1,
    );
  }
}
