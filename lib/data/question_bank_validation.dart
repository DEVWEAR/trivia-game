import 'question_model.dart';

String normalizeQuestion(String value) => value
    .toLowerCase()
    .replaceAll(RegExp('[\u064B-\u065F\u0670\u0640]'), '')
    .replaceAll(RegExp('[أإآ]'), 'ا')
    .replaceAll(RegExp(r'[^\w\u0600-\u06FF]+'), ' ')
    .trim();

/// Structural checks cannot certify source evidence or translation equivalence.
List<String> validateQuestionBank(
  String categoryId,
  List<TriviaQuestion> questions, {
  Set<String>? globalIds,
  DateTime? today,
}) {
  final errors = <String>[];
  final ids = globalIds ?? <String>{};
  final ar = <String>{}, en = <String>{}, facts = <String>{};
  if (questions.length != 204) {
    errors.add('$categoryId: expected 204, found ${questions.length}');
  }
  for (final difficulty in QuestionDifficulty.values) {
    final count = questions.where((q) => q.difficulty == difficulty).length;
    if (count != 68) errors.add('$categoryId: ${difficulty.points}: $count/68');
  }
  for (final q in questions) {
    void fail(String message) => errors.add('${q.id}: $message');
    if (q.id.trim().isEmpty || !ids.add(q.id)) fail('missing/duplicate ID');
    if (q.categoryId != categoryId) fail('wrong categoryId');
    for (final entry in {
      'questionAr': q.questionAr, 'questionEn': q.questionEn,
      'answerAr': q.answerAr, 'answerEn': q.answerEn,
      'sourceName': q.sourceName,
    }.entries) {
      if (entry.value.trim().isEmpty) fail('empty ${entry.key}');
    }
    final url = Uri.tryParse(q.sourceUrl);
    if (url == null || !['https', 'http'].contains(url.scheme) ||
        url.host.isEmpty || url.userInfo.isNotEmpty) fail('invalid sourceUrl');
    final date = today ?? DateTime.now();
    if (q.lastVerified.isAfter(DateTime(date.year, date.month, date.day, 23, 59, 59))) {
      fail('future lastVerified');
    }
    if (!ar.add(normalizeQuestion(q.questionAr))) fail('duplicate Arabic prompt');
    if (!en.add(normalizeQuestion(q.questionEn))) fail('duplicate English prompt');
    final fact = q.factKey?.trim() ?? '';
    if (fact.isEmpty) { fail('missing factKey'); }
    else if (!facts.add(fact)) { fail('duplicate factKey'); }
    if (q.mediaType != QuestionMediaType.none &&
        (q.mediaAsset == null || q.mediaAsset!.trim().isEmpty)) {
      fail('media has no asset');
    }
  }
  // Candidate review: high token overlap, not automatic semantic equivalence.
  for (var i = 0; i < questions.length; i++) {
    final a = normalizeQuestion(questions[i].questionEn).split(' ').toSet();
    for (var j = i + 1; j < questions.length; j++) {
      final b = normalizeQuestion(questions[j].questionEn).split(' ').toSet();
      final union = a.union(b).length;
      if (union > 0 && a.intersection(b).length / union >= 0.85) {
        errors.add('${questions[i].id}/${questions[j].id}: near-duplicate review required');
      }
    }
  }
  return errors;
}
