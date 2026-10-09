import '../question_model.dart';
import 'ligue_1/easy_1.dart';
import 'ligue_1/easy_2.dart';
import 'ligue_1/medium_1.dart';
import 'ligue_1/medium_2.dart';
import 'ligue_1/hard_1.dart';
import 'ligue_1/hard_2.dart';

/// Ligue 1: 204 verified bilingual questions, 68 per difficulty.
final ligue_1FinalQuestions = <TriviaQuestion>[
  ...ligue_1Easy1,
  ...ligue_1Easy2,
  ...ligue_1Medium1,
  ...ligue_1Medium2,
  ...ligue_1Hard1,
  ...ligue_1Hard2,
];
