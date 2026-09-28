import '../question_model.dart';

// UAE Football 101–102 — verified 2026-09-28 from official UAE Pro League sources.
final uaeFootballQuestions101To102 = <TriviaQuestion>[
  TriviaQuestion(
    id:'uae_football_101',
    categoryId:'uae_football',
    difficulty:QuestionDifficulty.medium400,
    questionAr:'أي نادٍ سجل 73 هدفاً في موسم الدوري الإماراتي للمحترفين 2023-2024، ليأتي ثانياً في قائمة أعلى حصيلة تهديفية لموسم واحد حتى أغسطس 2026؟',
    questionEn:'Which club scored 73 goals in the 2023-24 UAE Pro League season, ranking second for the highest single-season team total through August 2026?',
    answerAr:'شباب الأهلي',
    answerEn:'Shabab Al Ahli',
    sourceName:'UAE Pro League – Historic Single-Season Scoring Charts',
    sourceUrl:'https://www.uaeproleague.ae/en/news-and-gallery/al-ain-lead-historic-single-season-scoring-charts-with-74-goals',
    lastVerified:DateTime(2026,9,28),
  ),
  TriviaQuestion(
    id:'uae_football_102',
    categoryId:'uae_football',
    difficulty:QuestionDifficulty.hard600,
    questionAr:'كم هدفاً سجل الجزيرة في موسم الدوري الإماراتي للمحترفين 2016-2017 ليحتل المركز الثالث تاريخياً في حصيلة الأهداف لموسم واحد حتى أغسطس 2026؟',
    questionEn:'How many goals did Al Jazira score in the 2016-17 UAE Pro League season to rank third historically for a single-season team total through August 2026?',
    answerAr:'72 هدفاً',
    answerEn:'72 goals',
    sourceName:'UAE Pro League – Historic Single-Season Scoring Charts',
    sourceUrl:'https://www.uaeproleague.ae/en/news-and-gallery/al-ain-lead-historic-single-season-scoring-charts-with-74-goals',
    lastVerified:DateTime(2026,9,28),
  ),
];
