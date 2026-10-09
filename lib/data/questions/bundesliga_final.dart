import '../question_model.dart';
import 'bundesliga/easy_1.dart';
import 'bundesliga/easy_2.dart';
import 'bundesliga/medium_1.dart';
import 'bundesliga/medium_2.dart';
import 'bundesliga/hard_1.dart';
import 'bundesliga/hard_2.dart';

/// Bundesliga: 204 verified bilingual questions, 68 per difficulty.
final bundesligaFinalQuestions = <TriviaQuestion>[
  ...bundesligaEasy1,
  ...bundesligaEasy2,
  ...bundesligaMedium1,
  ...bundesligaMedium2,
  ...bundesligaHard1,
  ...bundesligaHard2,
];
