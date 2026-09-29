import '../question_model.dart';
import 'no_words_questions_001_034.dart';
import 'no_words_questions_035_068.dart';
import 'no_words_questions_069_102.dart';

/// FINAL No Words bank — 102 unique party cards.
/// 34 easy (200), 34 medium (400), 34 hard (600).
final noWordsFinalQuestions=<TriviaQuestion>[
  ...noWordsQuestions001To034,
  ...noWordsQuestions035To068,
  ...noWordsQuestions069To102,
];