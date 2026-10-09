import '../lib/data/question_model.dart';
import '../lib/data/question_bank_validation.dart';

void expect(bool condition, String message) {
  if (!condition) throw StateError(message);
}

TriviaQuestion fixture(int i, {String? fact, String? url, String? category}) => TriviaQuestion(
  id: 'test_$i', categoryId: category ?? 'test',
  difficulty: QuestionDifficulty.values[i ~/ 68],
  questionAr: 'سؤال رقم $i', questionEn: 'Fixture $i',
  answerAr: 'إجابة', answerEn: 'Answer', sourceName: 'Fixture source',
  sourceUrl: url ?? 'https://example.org/evidence/$i',
  lastVerified: DateTime(2026, 10, 6), factKey: fact ?? 'fact:$i',
);

void main() {
  final today = DateTime(2026, 10, 6);
  final bank = List.generate(204, fixture);
  expect(validateQuestionBank('test', bank, today: today).isEmpty, 'Balanced fixture should pass');
  expect(validateQuestionBank('test', bank.take(102).toList(), today: today)
      .any((e) => e.contains('expected 204')), 'Partial bank must fail');
  final duplicate = [...bank]..[203] = bank[0];
  final errors = validateQuestionBank('test', duplicate, today: today);
  for (final rule in ['duplicate ID', 'duplicate Arabic', 'duplicate English', 'duplicate factKey']) {
    expect(errors.any((e) => e.contains(rule)), 'Missing detection: $rule');
  }
  final invalid = [...bank]..[0] = fixture(0, url: 'invalid', category: 'wrong');
  final invalidErrors = validateQuestionBank('test', invalid, today: today);
  expect(invalidErrors.any((e) => e.contains('sourceUrl')), 'Bad URL must fail');
  expect(invalidErrors.any((e) => e.contains('categoryId')), 'Wrong category must fail');
  expect(normalizeQuestion('إجابةٌ؟') == normalizeQuestion('اجابة؟'), 'Arabic normalization');
  print('Question-bank validator regression checks passed.');
}
