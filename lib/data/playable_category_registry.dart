import 'questions/sharjah_questions.dart';
import 'questions/world_cup_questions.dart';
import 'question_model.dart';
import 'questions/el_clasico_questions.dart';

class PlayableCategory {
  const PlayableCategory(this.categoryId, this.icon, this.ar, this.en, this.questions);
  final String categoryId, icon, ar, en;
  final List<TriviaQuestion> questions;
}

// World Cup and El Clasico are published bilingual categories.
final playableCategories = <PlayableCategory>[
  PlayableCategory('sharjah', '🏰', 'إمارة الشارقة', 'Emirate of Sharjah', sharjahQuestions),
  PlayableCategory('world_cup', '🏆🌍', 'كأس العالم', 'FIFA World Cup', worldCupQuestions),
  PlayableCategory('el_clasico', '⚽🇪🇸', 'الكلاسيكو الإسباني', 'El Clásico', elClasicoQuestions),
];
