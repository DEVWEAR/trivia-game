import '../question_model.dart';
import 'kuwait_general_batch1.dart';
import 'kuwait_general_batch2.dart';
import 'kuwait_general_batch3.dart';

/// Kuwait general knowledge: 300 bilingual questions, 100 per difficulty.
/// Source and translation editorial review remains necessary before a public release.
final kuwaitGeneralFinalQuestions = <TriviaQuestion>[
  ...kuwaitGeneralBatch1,
  ...kuwaitGeneralBatch2,
  ...kuwaitGeneralBatch3,
];
