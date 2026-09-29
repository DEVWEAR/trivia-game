import '../question_model.dart';
import 'brain_questions_001_034.dart';
import 'brain_questions_035_068.dart';
import 'brain_questions_069_102.dart';

/// FINAL Brain & Riddles bank — exactly 102 unique questions.
/// Distribution: 34 x 200, 34 x 400, 34 x 600.
final brainFinalQuestions=<TriviaQuestion>[
  ...brainQuestions001To034,
  ...brainQuestions035To068,
  ...brainQuestions069To102,
];
