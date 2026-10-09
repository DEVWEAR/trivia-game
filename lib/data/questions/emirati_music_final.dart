import '../question_model.dart';
import 'emirati_music/easy_1.dart';
import 'emirati_music/easy_2.dart';
import 'emirati_music/medium_1.dart';
import 'emirati_music/medium_2.dart';
import 'emirati_music/hard_1.dart';
import 'emirati_music/hard_2.dart';

/// Emirati Music: 204 verified bilingual questions, 68 per difficulty.
final emirati_musicFinalQuestions = <TriviaQuestion>[
  ...emirati_musicEasy1,
  ...emirati_musicEasy2,
  ...emirati_musicMedium1,
  ...emirati_musicMedium2,
  ...emirati_musicHard1,
  ...emirati_musicHard2,
];
