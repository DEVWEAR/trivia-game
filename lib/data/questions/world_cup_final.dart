import '../question_model.dart';
import 'world_cup/easy_1.dart';
import 'world_cup/easy_2.dart';
import 'world_cup/medium_1.dart';
import 'world_cup/medium_2.dart';
import 'world_cup/hard_1.dart';
import 'world_cup/hard_2.dart';

/// World Cup: 204 verified bilingual questions, 68 per difficulty.
final world_cupFinalQuestions = <TriviaQuestion>[
  ...world_cupEasy1,
  ...world_cupEasy2,
  ...world_cupMedium1,
  ...world_cupMedium2,
  ...world_cupHard1,
  ...world_cupHard2,
];
