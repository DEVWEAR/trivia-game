import 'question_model.dart';
import 'questions/el_clasico_questions.dart';

class PlayableCategory {
  const PlayableCategory(this.categoryId, this.icon, this.ar, this.en, this.questions);
  final String categoryId, icon, ar, en;
  final List<TriviaQuestion> questions;
}

// Keep the first seven indexes stable, including the two picture-game modes.
final playableCategories = <PlayableCategory>[
  PlayableCategory('uae_general', '🇦🇪', 'الإمارات', 'UAE', <TriviaQuestion>[] ),
  PlayableCategory('uae_football', '⚽', 'كرة القدم الإماراتية', 'UAE Football', <TriviaQuestion>[] ),
  PlayableCategory('general_knowledge', '💡', 'معلومات عامة', 'General Knowledge', <TriviaQuestion>[] ),
  PlayableCategory('brain', '🧠', 'ألغاز وذكاء', 'Brain & Riddles', <TriviaQuestion>[] ),
  PlayableCategory('gaming', '🎮', 'ألعاب الفيديو', 'Gaming', <TriviaQuestion>[] ),
  PlayableCategory('no_words', '🎯', 'تلميح', 'Hint', <TriviaQuestion>[] ),
  PlayableCategory('two_pics', '🖼️', 'صورتين كلمة واحدة', 'Two Pics One Word', <TriviaQuestion>[] ),
  PlayableCategory('uae_heritage', '🏺', 'تراث الإمارات', 'UAE Heritage', <TriviaQuestion>[] ),
  PlayableCategory('gulf_culture', '🌴', 'الثقافة الخليجية', 'Gulf Culture', <TriviaQuestion>[] ),
  PlayableCategory('kuwait_general', '🇰🇼', 'الكويت', 'Kuwait', <TriviaQuestion>[] ),
  PlayableCategory('saudi_general', '🇸🇦', 'السعودية', 'Saudi Arabia', <TriviaQuestion>[] ),
  PlayableCategory('uae_pro_league', '⚽', 'الدوري الإماراتي', 'UAE Pro League', <TriviaQuestion>[] ),
  PlayableCategory('premier_league', '⚽', 'الدوري الإنجليزي', 'Premier League', <TriviaQuestion>[] ),
  PlayableCategory('la_liga', '⚽', 'الدوري الإسباني', 'La Liga', <TriviaQuestion>[] ),
  PlayableCategory('serie_a', '⚽', 'الدوري الإيطالي', 'Serie A', <TriviaQuestion>[] ),
  PlayableCategory('bundesliga', '⚽', 'الدوري الألماني', 'Bundesliga', <TriviaQuestion>[] ),
  PlayableCategory('ligue_1', '⚽', 'الدوري الفرنسي', 'Ligue 1', <TriviaQuestion>[] ),
  PlayableCategory('ucl', '🏆', 'دوري أبطال أوروبا', 'Champions League', <TriviaQuestion>[] ),
  PlayableCategory('world_cup', '🌍', 'كأس العالم', 'World Cup', <TriviaQuestion>[] ),
  PlayableCategory('football_legends', '⭐', 'أساطير كرة القدم', 'Football Legends', <TriviaQuestion>[] ),
  PlayableCategory('emirati_music', '🎵', 'أغاني إماراتية', 'Emirati Music', <TriviaQuestion>[] ),
  PlayableCategory('gulf_music', '🎶', 'أغاني خليجية', 'Gulf Music', <TriviaQuestion>[] ),
  PlayableCategory('kuwaiti_music', '🎤', 'أغاني كويتية', 'Kuwaiti Music', <TriviaQuestion>[] ),
  PlayableCategory('saudi_music', '🎧', 'أغاني سعودية', 'Saudi Music', <TriviaQuestion>[] ),
  PlayableCategory('egyptian_music', '🎙️', 'أغاني مصرية', 'Egyptian Music', <TriviaQuestion>[] ),
  PlayableCategory('arabic_music', '🎼', 'أغاني عربية', 'Arabic Music', <TriviaQuestion>[] ),
  PlayableCategory('international_music', '🌎', 'أغاني أجنبية', 'International Music', <TriviaQuestion>[] ),
  PlayableCategory('el_clasico', '⚽', 'الكلاسيكو الإسباني', 'El Clásico', elClasicoQuestions),
  PlayableCategory('old_school_music', '📻', 'أغاني الزمن الجميل', 'Old School Music', <TriviaQuestion>[] ),
];

