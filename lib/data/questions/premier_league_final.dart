import '../question_model.dart';
import 'premier_league/easy_1.dart';
import 'premier_league/easy_2.dart';
import 'premier_league/medium_1.dart';
import 'premier_league/medium_2.dart';
import 'premier_league/hard_1.dart';
import 'premier_league/hard_2.dart';

/// Premier League: 204 verified bilingual questions, 68 per difficulty.
final premierLeagueFinalQuestions = <TriviaQuestion>[
  ...premierLeagueEasy1,
  ...premierLeagueEasy2,
  ...premierLeagueMedium1,
  ...premierLeagueMedium2,
  ...premierLeagueHard1,
  ...premierLeagueHard2,
];
