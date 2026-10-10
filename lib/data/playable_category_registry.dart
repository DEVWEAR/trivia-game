import 'question_model.dart';
import 'questions/uae_general_final.dart';
import 'questions/uae_football_final.dart';
import 'questions/general_knowledge_final.dart';
import 'questions/brain_final.dart';
import 'questions/gaming_final.dart';
import 'questions/no_words_final.dart';
import 'questions/two_pics_final.dart';
import 'questions/uae_heritage_final.dart';
import 'questions/gulf_culture_final.dart';
import 'questions/kuwait_general_final.dart';
import 'questions/saudi_general_final.dart';
import 'questions/uae_pro_league_final.dart';
import 'questions/premier_league_final.dart';
import 'questions/la_liga_final.dart';
import 'questions/serie_a_final.dart';
import 'questions/bundesliga_final.dart';
import 'questions/ligue_1_final.dart';
import 'questions/ucl_final.dart';
import 'questions/world_cup_final.dart';
import 'questions/football_legends_final.dart';
import 'questions/emirati_music_final.dart';
import 'questions/gulf_music_final.dart';
import 'questions/kuwaiti_music_final.dart';
import 'questions/saudi_music_final.dart';
import 'questions/egyptian_music_final.dart';
import 'questions/arabic_music_final.dart';
import 'questions/international_music_final.dart';
import 'questions/old_school_music_final.dart';

class PlayableCategory {
  const PlayableCategory(this.categoryId, this.icon, this.ar, this.en, this.questions);
  final String categoryId, icon, ar, en;
  final List<TriviaQuestion> questions;
}

// Keep the first seven indexes stable, including the two picture-game modes.
final playableCategories = <PlayableCategory>[
  PlayableCategory('uae_general', '🇦🇪', 'الإمارات', 'UAE', uaeGeneralFinalQuestions),
  PlayableCategory('uae_football', '⚽', 'كرة القدم الإماراتية', 'UAE Football', uaeFootballFinalQuestions),
  PlayableCategory('general_knowledge', '💡', 'معلومات عامة', 'General Knowledge', generalKnowledgeFinalQuestions),
  PlayableCategory('brain', '🧠', 'ألغاز وذكاء', 'Brain & Riddles', brainFinalQuestions),
  PlayableCategory('gaming', '🎮', 'ألعاب الفيديو', 'Gaming', gamingFinalQuestions),
  PlayableCategory('no_words', '🎯', 'تلميح', 'Hint', noWordsFinalQuestions),
  PlayableCategory('two_pics', '🖼️', 'صورتين كلمة واحدة', 'Two Pics One Word', twoPicsFinalQuestions),
  PlayableCategory('uae_heritage', '🏺', 'تراث الإمارات', 'UAE Heritage', uaeHeritageFinalQuestions),
  PlayableCategory('gulf_culture', '🌴', 'الثقافة الخليجية', 'Gulf Culture', gulfCultureFinalQuestions),
  PlayableCategory('kuwait_general', '🇰🇼', 'الكويت', 'Kuwait', kuwaitGeneralFinalQuestions),
  PlayableCategory('saudi_general', '🇸🇦', 'السعودية', 'Saudi Arabia', saudiGeneralFinalQuestions),
  PlayableCategory('uae_pro_league', '⚽', 'الدوري الإماراتي', 'UAE Pro League', uaeProLeagueFinalQuestions),
  PlayableCategory('premier_league', '⚽', 'الدوري الإنجليزي', 'Premier League', premierLeagueFinalQuestions),
  PlayableCategory('la_liga', '⚽', 'الدوري الإسباني', 'La Liga', laLigaFinalQuestions),
  PlayableCategory('serie_a', '⚽', 'الدوري الإيطالي', 'Serie A', serieAFinalQuestions),
  PlayableCategory('bundesliga', '⚽', 'الدوري الألماني', 'Bundesliga', bundesligaFinalQuestions),
  PlayableCategory('ligue_1', '⚽', 'الدوري الفرنسي', 'Ligue 1', ligue_1FinalQuestions),
  PlayableCategory('ucl', '🏆', 'دوري أبطال أوروبا', 'Champions League', uclFinalQuestions),
  PlayableCategory('world_cup', '🌍', 'كأس العالم', 'World Cup', world_cupFinalQuestions),
  PlayableCategory('football_legends', '⭐', 'أساطير كرة القدم', 'Football Legends', football_legendsFinalQuestions),
  PlayableCategory('emirati_music', '🎵', 'أغاني إماراتية', 'Emirati Music', emirati_musicFinalQuestions),
  PlayableCategory('gulf_music', '🎶', 'أغاني خليجية', 'Gulf Music', gulf_musicFinalQuestions),
  PlayableCategory('kuwaiti_music', '🎤', 'أغاني كويتية', 'Kuwaiti Music', kuwaiti_musicFinalQuestions),
  PlayableCategory('saudi_music', '🎧', 'أغاني سعودية', 'Saudi Music', saudi_musicFinalQuestions),
  PlayableCategory('egyptian_music', '🎙️', 'أغاني مصرية', 'Egyptian Music', egyptian_musicFinalQuestions),
  PlayableCategory('arabic_music', '🎼', 'أغاني عربية', 'Arabic Music', arabic_musicFinalQuestions),
  PlayableCategory('international_music', '🌎', 'أغاني أجنبية', 'International Music', international_musicFinalQuestions),
  PlayableCategory('old_school_music', '📻', 'أغاني الزمن الجميل', 'Old School Music', old_school_musicFinalQuestions),
];

