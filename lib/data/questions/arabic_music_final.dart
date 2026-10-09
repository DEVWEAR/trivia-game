import '../question_model.dart';
import 'arabic_music/easy_1.dart';
import 'arabic_music/easy_2.dart';
import 'arabic_music/medium_1.dart';
import 'arabic_music/medium_2.dart';
import 'arabic_music/hard_1.dart';
import 'arabic_music/hard_2.dart';

/// Arabic Music: 204 verified bilingual questions, 68 per difficulty.
final arabic_musicFinalQuestions = <TriviaQuestion>[
  ...arabic_musicEasy1,
  ...arabic_musicEasy2,
  ...arabic_musicMedium1,
  ...arabic_musicMedium2,
  ...arabic_musicHard1,
  ...arabic_musicHard2,
];
