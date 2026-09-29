import '../question_model.dart';
import 'space_questions_001_012.dart';
import 'space_questions_013_102.dart';

/// FINAL Space bank — exactly 102 questions.
/// Distribution: 34 x 200, 34 x 400, 34 x 600.
final spaceFinalQuestions=<TriviaQuestion>[
  ...spaceQuestions001To012,
  ...spaceQuestions013To102,
];
