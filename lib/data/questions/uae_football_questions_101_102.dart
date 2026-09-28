import '../question_model.dart';

// UAE Football 101–102 — verified 2026-09-28 from UAE Pro League.
final uaeFootballQuestions101To102 = <TriviaQuestion>[
  TriviaQuestion(
    id:'uae_football_101',
    categoryId:'uae_football',
    difficulty:QuestionDifficulty.medium400,
    questionAr:'أي نادٍ إماراتي فاز بالدوري في عصر الاحتراف مواسم 2010-2011 و2016-2017 و2020-2021؟',
    questionEn:'Which UAE club won the professional-era league in 2010-11, 2016-17 and 2020-21?',
    answerAr:'الجزيرة',
    answerEn:'Al Jazira',
    sourceName:'UAE Pro League – Champions of the Professional Era',
    sourceUrl:'https://uaeproleague.ae/en/news-and-gallery/champions-of-the-professional-era-a-legacy-of-adnoc-pro-league-excellence',
    lastVerified:DateTime(2026,9,28),
  ),
  TriviaQuestion(
    id:'uae_football_102',
    categoryId:'uae_football',
    difficulty:QuestionDifficulty.hard600,
    questionAr:'أي نادٍ يتصدر قائمة الانتصارات التاريخية في الدوري الإماراتي للمحترفين بـ258 فوزاً حتى أغسطس 2026؟',
    questionEn:'Which club led the UAE Pro League all-time wins list with 258 victories as of August 2026?',
    answerAr:'العين',
    answerEn:'Al Ain',
    sourceName:'UAE Pro League – All-Time Wins List',
    sourceUrl:'https://uaeproleague.ae/en/news-and-gallery/al-ain-lead-uae-pro-leagues-all-time-wins-list',
    lastVerified:DateTime(2026,9,28),
  ),
];
