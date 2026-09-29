import '../question_model.dart';
import 'gaming_questions_001_034.dart';
import 'gaming_questions_035_068.dart';
import 'gaming_questions_069_102.dart';

/// FINAL Gaming bank — exactly 102 unique questions.
/// Distribution: 34 x 200, 34 x 400, 34 x 600.
final gamingFinalQuestions=<TriviaQuestion>[
  ...gamingQuestions001To034,
  ...gamingQuestions035To068,
  ...gamingQuestions069To102,
];
