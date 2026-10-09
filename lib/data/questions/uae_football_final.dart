import '../question_model.dart';
import 'uae_football/easy_1.dart';
import 'uae_football/easy_2.dart';
import 'uae_football/medium_1.dart';
import 'uae_football/medium_2.dart';
import 'uae_football/hard_1.dart';
import 'uae_football/hard_2.dart';

/// UAE Football: 204 verified bilingual questions, 68 per difficulty.
final uaeFootballFinalQuestions = <TriviaQuestion>[
  ...uaeFootballEasy1,
  ...uaeFootballEasy2,
  ...uaeFootballMedium1,
  ...uaeFootballMedium2,
  ...uaeFootballHard1,
  ...uaeFootballHard2,
];
