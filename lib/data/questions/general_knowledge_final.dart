import '../question_model.dart';
import 'general_knowledge_questions_001_034.dart';
import 'general_knowledge_questions_035_068.dart';
import 'general_knowledge_questions_069_102.dart';

/// FINAL General Knowledge bank — exactly 102 questions.
/// Distribution: 34 x 200, 34 x 400, 34 x 600.
final generalKnowledgeFinalQuestions=<TriviaQuestion>[
  ...generalKnowledgeQuestions001To034,
  ...generalKnowledgeQuestions035To068,
  ...generalKnowledgeQuestions069To102,
];
