import 'questions/world_cup_questions.dart';
import 'question_model.dart';
import 'questions/el_clasico_questions.dart';

class PlayableCategory {
  const PlayableCategory(this.categoryId, this.icon, this.ar, this.en, this.questions);
  final String categoryId, icon, ar, en;
  final List<TriviaQuestion> questions;
}

// Rebuild categories one at a time as bilingual question banks are verified.
final playableCategories = <PlayableCategory>[
  PlayableCategory('world_cup', '🏆🌍', 'كأس العالم', 'FIFA World Cup', worldCupQuestions),
  PlayableCategory('el_clasico', '⚽🇪🇸', 'الكلاسيكو الإسباني', 'El Clásico', elClasicoQuestions),
];
