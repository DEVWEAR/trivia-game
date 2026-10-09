import '../question_model.dart';
import 'old_school_music/easy_1.dart';
import 'old_school_music/easy_2.dart';
import 'old_school_music/medium_1.dart';
import 'old_school_music/medium_2.dart';
import 'old_school_music/hard_1.dart';
import 'old_school_music/hard_2.dart';

/// Old School Music: 204 verified bilingual questions, 68 per difficulty.
final old_school_musicFinalQuestions = <TriviaQuestion>[
  ...old_school_musicEasy1,
  ...old_school_musicEasy2,
  ...old_school_musicMedium1,
  ...old_school_musicMedium2,
  ...old_school_musicHard1,
  ...old_school_musicHard2,
];
