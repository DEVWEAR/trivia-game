import '../question_model.dart';
import 'uae_general/easy_1.dart';
import 'uae_general/easy_2.dart';
import 'uae_general/medium_1.dart';
import 'uae_general/medium_2.dart';
import 'uae_general/hard_1.dart';
import 'uae_general/hard_2.dart';

/// UAE: 204 verified bilingual questions, 68 per difficulty.
final uaeGeneralFinalQuestions = <TriviaQuestion>[
  ...uaeGeneralEasy1,
  ...uaeGeneralEasy2,
  ...uaeGeneralMedium1,
  ...uaeGeneralMedium2,
  ...uaeGeneralHard1,
  ...uaeGeneralHard2,
];
