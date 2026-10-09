import '../question_model.dart';
import 'ucl/easy_1.dart';
import 'ucl/easy_2.dart';
import 'ucl/medium_1.dart';
import 'ucl/medium_2.dart';
import 'ucl/hard_1.dart';
import 'ucl/hard_2.dart';

/// Champions League: 204 verified bilingual questions, 68 per difficulty.
final uclFinalQuestions = <TriviaQuestion>[
  ...uclEasy1,
  ...uclEasy2,
  ...uclMedium1,
  ...uclMedium2,
  ...uclHard1,
  ...uclHard2,
];
