import '../question_model.dart';
import 'la_liga/easy_1.dart';
import 'la_liga/easy_2.dart';
import 'la_liga/medium_1.dart';
import 'la_liga/medium_2.dart';
import 'la_liga/hard_1.dart';
import 'la_liga/hard_2.dart';

/// La Liga: 204 verified bilingual questions, 68 per difficulty.
final laLigaFinalQuestions = <TriviaQuestion>[
  ...laLigaEasy1,
  ...laLigaEasy2,
  ...laLigaMedium1,
  ...laLigaMedium2,
  ...laLigaHard1,
  ...laLigaHard2,
];
