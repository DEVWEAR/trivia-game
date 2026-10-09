import '../question_model.dart';
import 'international_music/easy_1.dart';
import 'international_music/easy_2.dart';
import 'international_music/medium_1.dart';
import 'international_music/medium_2.dart';
import 'international_music/hard_1.dart';
import 'international_music/hard_2.dart';

/// International Music: 204 verified bilingual questions, 68 per difficulty.
final international_musicFinalQuestions = <TriviaQuestion>[
  ...international_musicEasy1,
  ...international_musicEasy2,
  ...international_musicMedium1,
  ...international_musicMedium2,
  ...international_musicHard1,
  ...international_musicHard2,
];
