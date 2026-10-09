import '../question_model.dart';
import 'kuwaiti_music/easy_1.dart';
import 'kuwaiti_music/easy_2.dart';
import 'kuwaiti_music/medium_1.dart';
import 'kuwaiti_music/medium_2.dart';
import 'kuwaiti_music/hard_1.dart';
import 'kuwaiti_music/hard_2.dart';

/// Kuwaiti Music: 204 verified bilingual questions, 68 per difficulty.
final kuwaiti_musicFinalQuestions = <TriviaQuestion>[
  ...kuwaiti_musicEasy1,
  ...kuwaiti_musicEasy2,
  ...kuwaiti_musicMedium1,
  ...kuwaiti_musicMedium2,
  ...kuwaiti_musicHard1,
  ...kuwaiti_musicHard2,
];
