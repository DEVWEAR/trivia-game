import '../question_model.dart';
import 'kuwait_general/easy_1.dart';
import 'kuwait_general/easy_2.dart';
import 'kuwait_general/medium_1.dart';
import 'kuwait_general/medium_2.dart';
import 'kuwait_general/hard_1.dart';
import 'kuwait_general/hard_2.dart';

/// Kuwait: 204 verified bilingual questions, 68 per difficulty.
final kuwaitGeneralFinalQuestions = <TriviaQuestion>[
  ...kuwaitGeneralEasy1,
  ...kuwaitGeneralEasy2,
  ...kuwaitGeneralMedium1,
  ...kuwaitGeneralMedium2,
  ...kuwaitGeneralHard1,
  ...kuwaitGeneralHard2,
];
