import '../question_model.dart';
import 'serie_a/easy_1.dart';
import 'serie_a/easy_2.dart';
import 'serie_a/medium_1.dart';
import 'serie_a/medium_2.dart';
import 'serie_a/hard_1.dart';
import 'serie_a/hard_2.dart';

/// Serie A: 204 verified bilingual questions, 68 per difficulty.
final serieAFinalQuestions = <TriviaQuestion>[
  ...serieAEasy1,
  ...serieAEasy2,
  ...serieAMedium1,
  ...serieAMedium2,
  ...serieAHard1,
  ...serieAHard2,
];
