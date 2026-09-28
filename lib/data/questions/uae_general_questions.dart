import '../question_model.dart';

// Verified starter batch for UAE General.
// Sources are official UAE Government sources and Visit Dubai.
final uaeGeneralQuestions = <TriviaQuestion>[
  TriviaQuestion(
    id: 'uae_general_001', categoryId: 'uae_general', difficulty: QuestionDifficulty.easy200,
    questionAr: 'ما عاصمة دولة الإمارات العربية المتحدة؟', questionEn: 'What is the capital of the United Arab Emirates?',
    answerAr: 'أبوظبي', answerEn: 'Abu Dhabi',
    sourceName: 'UAE Government – Fact Sheet', sourceUrl: 'https://u.ae/en/about-the-uae/fact-sheet', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_002', categoryId: 'uae_general', difficulty: QuestionDifficulty.easy200,
    questionAr: 'كم إمارة تتكون منها دولة الإمارات العربية المتحدة؟', questionEn: 'How many emirates make up the United Arab Emirates?',
    answerAr: 'سبع إمارات', answerEn: 'Seven emirates',
    sourceName: 'UAE Cabinet – UAE', sourceUrl: 'https://uaecabinet.ae/en/uae', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_003', categoryId: 'uae_general', difficulty: QuestionDifficulty.easy200,
    questionAr: 'في أي تاريخ أُعلن رسمياً قيام دولة الإمارات العربية المتحدة؟', questionEn: 'On what date was the United Arab Emirates formally established?',
    answerAr: '2 ديسمبر 1971', answerEn: '2 December 1971',
    sourceName: 'UAE Government – History', sourceUrl: 'https://u.ae/en/about-the-uae/history', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_004', categoryId: 'uae_general', difficulty: QuestionDifficulty.medium400,
    questionAr: 'أي إمارة انضمت إلى اتحاد دولة الإمارات في 10 فبراير 1972؟', questionEn: 'Which emirate joined the UAE federation on 10 February 1972?',
    answerAr: 'رأس الخيمة', answerEn: 'Ras Al Khaimah',
    sourceName: 'UAE Government – History', sourceUrl: 'https://u.ae/en/about-the-uae/history', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_005', categoryId: 'uae_general', difficulty: QuestionDifficulty.medium400,
    questionAr: 'من كان أول رئيس لدولة الإمارات العربية المتحدة؟', questionEn: 'Who was the first President of the United Arab Emirates?',
    answerAr: 'الشيخ زايد بن سلطان آل نهيان', answerEn: 'Sheikh Zayed bin Sultan Al Nahyan',
    sourceName: 'UAE Government – Founders of the Union', sourceUrl: 'https://u.ae/en/about-uae/founders-of-the-union', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_006', categoryId: 'uae_general', difficulty: QuestionDifficulty.medium400,
    questionAr: 'ما اللغة الرسمية لدولة الإمارات العربية المتحدة؟', questionEn: 'What is the official language of the United Arab Emirates?',
    answerAr: 'اللغة العربية', answerEn: 'Arabic',
    sourceName: 'UAE Constitution', sourceUrl: 'https://uaecabinet.ae/en/the-constitution', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_007', categoryId: 'uae_general', difficulty: QuestionDifficulty.hard600,
    questionAr: 'في أي منطقة التقى الشيخ زايد بن سلطان والشيخ راشد بن سعيد في فبراير 1968 لبحث الاتحاد؟', questionEn: 'Where did Sheikh Zayed bin Sultan and Sheikh Rashid bin Saeed meet in February 1968 to discuss federation?',
    answerAr: 'السمحة', answerEn: 'Al Samha',
    sourceName: 'UAE Government – History', sourceUrl: 'https://u.ae/en/about-the-uae/history', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_008', categoryId: 'uae_general', difficulty: QuestionDifficulty.hard600,
    questionAr: 'في أي تاريخ انضمت رأس الخيمة إلى اتحاد دولة الإمارات؟', questionEn: 'On what date did Ras Al Khaimah join the UAE federation?',
    answerAr: '10 فبراير 1972', answerEn: '10 February 1972',
    sourceName: 'UAE Government – History', sourceUrl: 'https://u.ae/en/about-the-uae/history', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_009', categoryId: 'uae_general', difficulty: QuestionDifficulty.medium400,
    questionAr: 'كم يبلغ ارتفاع برج خليفة؟', questionEn: 'How tall is Burj Khalifa?',
    answerAr: '828 متراً', answerEn: '828 metres',
    sourceName: 'Visit Dubai – Burj Khalifa', sourceUrl: 'https://www.visitdubai.com/places-to-visit/burj-khalifa', lastVerified: DateTime(2026, 9, 28),
  ),
  TriviaQuestion(
    id: 'uae_general_010', categoryId: 'uae_general', difficulty: QuestionDifficulty.hard600,
    questionAr: 'متى عُقدت أول جلسة للمجلس الوطني الاتحادي؟', questionEn: 'When was the first session of the Federal National Council held?',
    answerAr: '13 فبراير 1972', answerEn: '13 February 1972',
    sourceName: 'UAE Government – Federal National Council', sourceUrl: 'https://u.ae/en/about-the-uae/the-uae-government/the-federal-national-council-', lastVerified: DateTime(2026, 9, 28),
  ),
];
