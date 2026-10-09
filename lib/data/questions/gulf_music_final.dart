import '../question_model.dart';
import 'gulf_music/easy_1.dart';
import 'gulf_music/easy_2.dart';
import 'gulf_music/medium_1.dart';
import 'gulf_music/medium_2.dart';
import 'gulf_music/hard_1.dart';
import 'gulf_music/hard_2.dart';

/// Gulf Music: 204 verified bilingual questions, 68 per difficulty.
final gulf_musicFinalQuestions = <TriviaQuestion>[
  ...gulf_musicEasy1,
  ...gulf_musicEasy2,
  ...gulf_musicMedium1,
  ...gulf_musicMedium2,
  ...gulf_musicHard1,
  ...gulf_musicHard2,
];
