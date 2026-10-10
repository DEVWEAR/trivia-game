import 'question_model.dart';
import 'questions/el_clasico_questions.dart';

class PlayableCategory {
  const PlayableCategory(this.categoryId, this.icon, this.ar, this.en, this.questions);
  final String categoryId, icon, ar, en;
  final List<TriviaQuestion> questions;
}

// Only El Clásico is visible until the remaining categories are rebuilt.
final playableCategories = <PlayableCategory>[
  PlayableCategory('el_clasico', '⚽🇪🇸', 'الكلاسيكو الإسباني', 'El Clásico', elClasicoQuestions),
];
