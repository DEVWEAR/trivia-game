import '../question_model.dart';
import 'gulf_culture/easy_1.dart';
import 'gulf_culture/easy_2.dart';
import 'gulf_culture/medium_1.dart';
import 'gulf_culture/medium_2.dart';
import 'gulf_culture/hard_1.dart';
import 'gulf_culture/hard_2.dart';

/// Gulf Culture: 204 verified bilingual questions, 68 per difficulty.
final gulfCultureFinalQuestions = <TriviaQuestion>[
  ...gulfCultureEasy1,
  ...gulfCultureEasy2,
  ...gulfCultureMedium1,
  ...gulfCultureMedium2,
  ...gulfCultureHard1,
  ...gulfCultureHard2,
];
