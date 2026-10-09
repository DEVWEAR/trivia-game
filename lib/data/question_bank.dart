import 'question_model.dart';
import 'questions/uae_football_final.dart';
import 'questions/uae_general_final.dart';
import 'questions/general_knowledge_final.dart';
import 'questions/brain_final.dart';
import 'questions/gaming_final.dart';
import 'questions/space_final.dart';
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

/// Existing catalog banks under audit. Membership does not certify content.
/// Replacements must replace a category's list here, never append the old bank.
final catalogQuestionBanks = <String, List<TriviaQuestion>>{
  'uae_football': uaeFootballFinalQuestions,
  'uae_general': uaeGeneralFinalQuestions,
  'general_knowledge': generalKnowledgeFinalQuestions,
  'brain': brainFinalQuestions,
  'gaming': gamingFinalQuestions,
  'space': spaceFinalQuestions,
  'uae_heritage': uaeHeritageFinalQuestions,
  'gulf_culture': gulfCultureFinalQuestions,
  'kuwait_general': kuwaitGeneralFinalQuestions,
  'saudi_general': saudiGeneralFinalQuestions,
  'uae_pro_league': uaeProLeagueFinalQuestions,
  'premier_league': premierLeagueFinalQuestions,
  'la_liga': laLigaFinalQuestions,
  'serie_a': serieAFinalQuestions,
  'bundesliga': bundesligaFinalQuestions,
  'ligue_1': ligue_1FinalQuestions,
  'ucl': uclFinalQuestions,
  'world_cup': world_cupFinalQuestions,
  'football_legends': football_legendsFinalQuestions,
  'emirati_music': emirati_musicFinalQuestions,
  'gulf_music': gulf_musicFinalQuestions,
  'kuwaiti_music': kuwaiti_musicFinalQuestions,
  'saudi_music': saudi_musicFinalQuestions,
  'egyptian_music': egyptian_musicFinalQuestions,
  'arabic_music': arabic_musicFinalQuestions,
  'international_music': international_musicFinalQuestions,
  'old_school_music': old_school_musicFinalQuestions,
};

