import '../question_model.dart';
import 'football_legends/easy_1.dart';
import 'football_legends/easy_2.dart';
import 'football_legends/medium_1.dart';
import 'football_legends/medium_2.dart';
import 'football_legends/hard_1.dart';
import 'football_legends/hard_2.dart';

/// Football Legends: 204 verified bilingual questions, 68 per difficulty.
final football_legendsFinalQuestions = <TriviaQuestion>[
  ...football_legendsEasy1,
  ...football_legendsEasy2,
  ...football_legendsMedium1,
  ...football_legendsMedium2,
  ...football_legendsHard1,
  ...football_legendsHard2,
];
