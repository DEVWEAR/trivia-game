import '../question_model.dart';
import 'saudi_general/easy_1.dart';
import 'saudi_general/easy_2.dart';
import 'saudi_general/medium_1.dart';
import 'saudi_general/medium_2.dart';
import 'saudi_general/hard_1.dart';
import 'saudi_general/hard_2.dart';

/// Saudi Arabia: 204 verified bilingual questions, 68 per difficulty.
final saudiGeneralFinalQuestions = <TriviaQuestion>[
  ...saudiGeneralEasy1,
  ...saudiGeneralEasy2,
  ...saudiGeneralMedium1,
  ...saudiGeneralMedium2,
  ...saudiGeneralHard1,
  ...saudiGeneralHard2,
];
