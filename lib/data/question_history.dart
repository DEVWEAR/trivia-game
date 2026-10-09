/// Account-scoped history contract. Implement with an account backend when login
/// is introduced. Mark only opened questions, never all six allocated tiles.
abstract class QuestionHistory {
  Set<String> seenIds(String accountId);
  void markShown(String accountId, String questionId);
}

/// Session implementation; intentionally makes no claim of durable storage.
class MemoryQuestionHistory implements QuestionHistory {
  final _accounts = <String, Set<String>>{};

  @override
  Set<String> seenIds(String accountId) =>
      Set.unmodifiable(_accounts[accountId] ?? <String>{});

  @override
  void markShown(String accountId, String questionId) {
    _accounts.putIfAbsent(accountId, () => <String>{}).add(questionId);
  }
}
