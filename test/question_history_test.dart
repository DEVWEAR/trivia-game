import '../lib/data/question_history.dart';

void main() {
  final history = MemoryQuestionHistory();
  history.markShown('account-a', 'uae_football_001');
  history.markShown('account-a', 'uae_football_001');
  if (history.seenIds('account-a').length != 1) {
    throw StateError('Repeated observations must be idempotent');
  }
  if (history.seenIds('account-b').isNotEmpty) {
    throw StateError('History must remain account-scoped');
  }
  final snapshot = history.seenIds('account-a');
  history.markShown('account-a', 'uae_football_002');
  if (snapshot.length != 1) throw StateError('History snapshots must be independent');
  print('Account history regression checks passed.');
}
