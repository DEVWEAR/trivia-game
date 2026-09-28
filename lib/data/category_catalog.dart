class TriviaCategory {
  const TriviaCategory({
    required this.id,
    required this.emoji,
    required this.ar,
    required this.en,
    required this.group,
    this.totalQuestions = 100,
  });

  final String id;
  final String emoji;
  final String ar;
  final String en;
  final String group;
  final int totalQuestions;
}

/// Every category has its own independent question pool.
/// A user's remaining count is tracked per category, never globally.
const triviaCategories = <TriviaCategory>[
  // UAE & Gulf
  TriviaCategory(id: 'uae_general', emoji: '🇦🇪', ar: 'الإمارات', en: 'UAE', group: 'culture'),
  TriviaCategory(id: 'uae_heritage', emoji: '🏜️', ar: 'تراث الإمارات', en: 'UAE Heritage', group: 'culture'),
  TriviaCategory(id: 'gulf_culture', emoji: '🌴', ar: 'الثقافة الخليجية', en: 'Gulf Culture', group: 'culture'),
  TriviaCategory(id: 'kuwait_general', emoji: '🇰🇼', ar: 'الكويت', en: 'Kuwait', group: 'culture'),
  TriviaCategory(id: 'saudi_general', emoji: '🇸🇦', ar: 'السعودية', en: 'Saudi Arabia', group: 'culture'),

  // Football — deliberately split by audience interest
  TriviaCategory(id: 'uae_football', emoji: '🇦🇪', ar: 'كرة القدم الإماراتية', en: 'UAE Football', group: 'football'),
  TriviaCategory(id: 'uae_pro_league', emoji: '⚽', ar: 'الدوري الإماراتي', en: 'UAE Pro League', group: 'football'),
  TriviaCategory(id: 'premier_league', emoji: '🏴', ar: 'الدوري الإنجليزي', en: 'Premier League', group: 'football'),
  TriviaCategory(id: 'la_liga', emoji: '🇪🇸', ar: 'الدوري الإسباني', en: 'La Liga', group: 'football'),
  TriviaCategory(id: 'serie_a', emoji: '🇮🇹', ar: 'الدوري الإيطالي', en: 'Serie A', group: 'football'),
  TriviaCategory(id: 'bundesliga', emoji: '🇩🇪', ar: 'الدوري الألماني', en: 'Bundesliga', group: 'football'),
  TriviaCategory(id: 'ligue_1', emoji: '🇫🇷', ar: 'الدوري الفرنسي', en: 'Ligue 1', group: 'football'),
  TriviaCategory(id: 'ucl', emoji: '🏆', ar: 'دوري أبطال أوروبا', en: 'Champions League', group: 'football'),
  TriviaCategory(id: 'world_cup', emoji: '🌍', ar: 'كأس العالم', en: 'World Cup', group: 'football'),
  TriviaCategory(id: 'football_legends', emoji: '⭐', ar: 'أساطير كرة القدم', en: 'Football Legends', group: 'football'),

  // Music
  TriviaCategory(id: 'emirati_music', emoji: '🎵', ar: 'أغاني إماراتية', en: 'Emirati Music', group: 'music'),
  TriviaCategory(id: 'gulf_music', emoji: '🎶', ar: 'أغاني خليجية', en: 'Gulf Music', group: 'music'),
  TriviaCategory(id: 'kuwaiti_music', emoji: '🎤', ar: 'أغاني كويتية', en: 'Kuwaiti Music', group: 'music'),
  TriviaCategory(id: 'saudi_music', emoji: '🎧', ar: 'أغاني سعودية', en: 'Saudi Music', group: 'music'),
  TriviaCategory(id: 'egyptian_music', emoji: '🎙️', ar: 'أغاني مصرية', en: 'Egyptian Music', group: 'music'),
  TriviaCategory(id: 'arabic_music', emoji: '🎼', ar: 'أغاني عربية', en: 'Arabic Music', group: 'music'),
  TriviaCategory(id: 'international_music', emoji: '🌎', ar: 'أغاني أجنبية', en: 'International Music', group: 'music'),
  TriviaCategory(id: 'old_school_music', emoji: '📻', ar: 'أغاني الزمن الجميل', en: 'Old School Music', group: 'music'),

  // Movies & TV
  TriviaCategory(id: 'emirati_screen', emoji: '🎬', ar: 'أفلام ومسلسلات إماراتية', en: 'Emirati Movies & TV', group: 'screen'),
  TriviaCategory(id: 'kuwaiti_screen', emoji: '📺', ar: 'أفلام ومسلسلات كويتية', en: 'Kuwaiti Movies & TV', group: 'screen'),
  TriviaCategory(id: 'gulf_screen', emoji: '🎞️', ar: 'أفلام ومسلسلات خليجية', en: 'Gulf Movies & TV', group: 'screen'),
  TriviaCategory(id: 'egyptian_screen', emoji: '🎥', ar: 'أفلام ومسلسلات مصرية', en: 'Egyptian Movies & TV', group: 'screen'),
  TriviaCategory(id: 'arabic_screen', emoji: '🍿', ar: 'أفلام ومسلسلات عربية', en: 'Arabic Movies & TV', group: 'screen'),
  TriviaCategory(id: 'international_movies', emoji: '🎦', ar: 'أفلام أجنبية', en: 'International Movies', group: 'screen'),
  TriviaCategory(id: 'turkish_series', emoji: '🇹🇷', ar: 'مسلسلات تركية', en: 'Turkish Series', group: 'screen'),
  TriviaCategory(id: 'korean_screen', emoji: '🇰🇷', ar: 'كوري', en: 'Korean Movies & TV', group: 'screen'),
  TriviaCategory(id: 'anime', emoji: '⛩️', ar: 'أنمي', en: 'Anime', group: 'screen'),
  TriviaCategory(id: 'cartoons', emoji: '🧸', ar: 'كرتون', en: 'Cartoons', group: 'screen'),

  // Cars
  TriviaCategory(id: 'cars_general', emoji: '🚗', ar: 'سيارات', en: 'Cars', group: 'cars'),
  TriviaCategory(id: 'japanese_cars', emoji: '🇯🇵', ar: 'سيارات يابانية', en: 'Japanese Cars', group: 'cars'),
  TriviaCategory(id: 'german_cars', emoji: '🇩🇪', ar: 'سيارات ألمانية', en: 'German Cars', group: 'cars'),
  TriviaCategory(id: 'american_cars', emoji: '🇺🇸', ar: 'سيارات أمريكية', en: 'American Cars', group: 'cars'),
  TriviaCategory(id: 'supercars', emoji: '🏎️', ar: 'سوبر كار', en: 'Supercars', group: 'cars'),
  TriviaCategory(id: 'classic_cars', emoji: '🛞', ar: 'سيارات كلاسيكية', en: 'Classic Cars', group: 'cars'),
  TriviaCategory(id: 'car_logos', emoji: '🔰', ar: 'شعارات السيارات', en: 'Car Logos', group: 'cars'),

  // General interests
  TriviaCategory(id: 'animals', emoji: '🐆', ar: 'الحيوانات', en: 'Animals', group: 'general'),
  TriviaCategory(id: 'world', emoji: '🌍', ar: 'حول العالم', en: 'Around the World', group: 'general'),
  TriviaCategory(id: 'gaming', emoji: '🎮', ar: 'ألعاب الفيديو', en: 'Gaming', group: 'general'),
  TriviaCategory(id: 'food', emoji: '🍜', ar: 'الأكل', en: 'Food', group: 'general'),
  TriviaCategory(id: 'history', emoji: '🏛️', ar: 'التاريخ', en: 'History', group: 'general'),
  TriviaCategory(id: 'science', emoji: '🔬', ar: 'العلوم', en: 'Science', group: 'general'),
  TriviaCategory(id: 'space', emoji: '🚀', ar: 'الفضاء', en: 'Space', group: 'general'),
  TriviaCategory(id: 'brain', emoji: '🧠', ar: 'ألغاز وذكاء', en: 'Brain & Riddles', group: 'general'),
  TriviaCategory(id: 'flags', emoji: '🚩', ar: 'الأعلام', en: 'Flags', group: 'general'),
  TriviaCategory(id: 'landmarks', emoji: '🗿', ar: 'معالم مشهورة', en: 'Landmarks', group: 'general'),
];
