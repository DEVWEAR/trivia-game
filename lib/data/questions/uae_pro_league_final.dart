import '../question_model.dart';
import 'uae_pro_league/easy_1.dart';
import 'uae_pro_league/easy_2.dart';
import 'uae_pro_league/medium_1.dart';
import 'uae_pro_league/medium_2.dart';
import 'uae_pro_league/hard_1.dart';
import 'uae_pro_league/hard_2.dart';

/// UAE Pro League: 204 verified bilingual questions, 68 per difficulty.
final uaeProLeagueFinalQuestions = <TriviaQuestion>[
  ...uaeProLeagueEasy1,
  ...uaeProLeagueEasy2,
  ...uaeProLeagueMedium1,
  ...uaeProLeagueMedium2,
  ...uaeProLeagueHard1,
  ...uaeProLeagueHard2,
];
