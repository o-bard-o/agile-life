import '../models/retrospective.dart';
import '../models/retrospective_draft.dart';

class RetrospectiveSaveResult {
  const RetrospectiveSaveResult({
    required this.retrospective,
    required this.wasCreated,
  });

  final Retrospective retrospective;
  final bool wasCreated;
}

abstract class RetrospectiveRepository {
  List<Retrospective> fetchRetrospectives();

  Retrospective? fetchBySprintId(String sprintId);

  RetrospectiveSaveResult saveRetrospective(RetrospectiveDraft draft);
}
