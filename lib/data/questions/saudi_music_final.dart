import '../question_model.dart';
import 'saudi_music/easy_1.dart';
import 'saudi_music/easy_2.dart';
import 'saudi_music/medium_1.dart';
import 'saudi_music/medium_2.dart';
import 'saudi_music/hard_1.dart';
import 'saudi_music/hard_2.dart';

/// Saudi Music: 204 verified bilingual questions, 68 per difficulty.
final saudi_musicFinalQuestions = <TriviaQuestion>[
  ...saudi_musicEasy1,
  ...saudi_musicEasy2,
  ...saudi_musicMedium1,
  ...saudi_musicMedium2,
  ...saudi_musicHard1,
  ...saudi_musicHard2,
];
