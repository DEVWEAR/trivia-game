import '../question_model.dart';
import 'uae_heritage/easy_1.dart';
import 'uae_heritage/easy_2.dart';
import 'uae_heritage/medium_1.dart';
import 'uae_heritage/medium_2.dart';
import 'uae_heritage/hard_1.dart';
import 'uae_heritage/hard_2.dart';

/// UAE Heritage: 204 verified bilingual questions, 68 per difficulty.
final uaeHeritageFinalQuestions = <TriviaQuestion>[
  ...uaeHeritageEasy1,
  ...uaeHeritageEasy2,
  ...uaeHeritageMedium1,
  ...uaeHeritageMedium2,
  ...uaeHeritageHard1,
  ...uaeHeritageHard2,
];
