import '../question_model.dart';
import 'egyptian_music/easy_1.dart';
import 'egyptian_music/easy_2.dart';
import 'egyptian_music/medium_1.dart';
import 'egyptian_music/medium_2.dart';
import 'egyptian_music/hard_1.dart';
import 'egyptian_music/hard_2.dart';

/// Egyptian Music: 204 verified bilingual questions, 68 per difficulty.
final egyptian_musicFinalQuestions = <TriviaQuestion>[
  ...egyptian_musicEasy1,
  ...egyptian_musicEasy2,
  ...egyptian_musicMedium1,
  ...egyptian_musicMedium2,
  ...egyptian_musicHard1,
  ...egyptian_musicHard2,
];
