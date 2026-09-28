import '../question_model.dart';
import 'uae_general_questions.dart';
import 'uae_general_questions_031_100.dart';

// FINAL production UAE General bank — exactly 100 questions.
// QA 2026-09-28: repetitive fixed-line-code questions and duplicate/overly similar
// Grand Mosque questions are excluded and replaced with verified heritage/culture questions.
const _excludedIds = <String>{
  'uae_general_076',
  'uae_general_077',
  'uae_general_078',
  'uae_general_079',
  'uae_general_080',
  'uae_general_081',
  'uae_general_084',
  'uae_general_088',
  'uae_general_089',
};

final uaeGeneralFinalQuestions = <TriviaQuestion>[
  ...uaeGeneralQuestions,
  ...uaeGeneralQuestions031To100.where((q) => !_excludedIds.contains(q.id)),

  TriviaQuestion(id:'uae_general_076',categoryId:'uae_general',difficulty:QuestionDifficulty.easy200,questionAr:'ما أقدم مبنى حجري قائم في مدينة أبوظبي؟',questionEn:'What is the oldest standing stone building in Abu Dhabi city?',answerAr:'قصر الحصن',answerEn:'Qasr Al Hosn',sourceName:'Experience Abu Dhabi – Qasr Al Hosn',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/heritage/qasr-al-hosn',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_077',categoryId:'uae_general',difficulty:QuestionDifficulty.medium400,questionAr:'في أي سنة بُني البرج الأصلي في موقع قصر الحصن بحسب المصدر السياحي الرسمي لأبوظبي؟',questionEn:'According to Experience Abu Dhabi, in what year was the original watchtower at Qasr Al Hosn built?',answerAr:'1790',answerEn:'1790',sourceName:'Experience Abu Dhabi – Qasr Al Hosn',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/heritage/qasr-al-hosn',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_078',categoryId:'uae_general',difficulty:QuestionDifficulty.medium400,questionAr:'ما اسم حرفة النسيج البدوية التقليدية المصنوعة من صوف الأغنام والإبل والماعز؟',questionEn:'What is the traditional Bedouin weaving craft made using sheep, camel and goat wool?',answerAr:'السدو',answerEn:'Al Sadu',sourceName:'Experience Abu Dhabi – Qasr Al Hosn',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/heritage/qasr-al-hosn',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_079',categoryId:'uae_general',difficulty:QuestionDifficulty.medium400,questionAr:'ما اسم الحرفة الإماراتية التقليدية التي تعتمد على نسج سعف النخيل؟',questionEn:'What is the traditional Emirati craft of weaving date-palm leaves called?',answerAr:'الخوص',answerEn:'Khoos',sourceName:'Experience Abu Dhabi – Qasr Al Hosn',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/heritage/qasr-al-hosn',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_080',categoryId:'uae_general',difficulty:QuestionDifficulty.hard600,questionAr:'في أي سنة أُدرجت القهوة العربية ضمن القائمة التمثيلية للتراث الثقافي غير المادي لليونسكو بمشاركة الإمارات؟',questionEn:'In what year was Arabic coffee inscribed on UNESCO’s Representative List of Intangible Cultural Heritage with UAE participation?',answerAr:'2015',answerEn:'2015',sourceName:'Experience Abu Dhabi – Bait Al Gahwa',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/heritage/bait-al-gahwa',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_081',categoryId:'uae_general',difficulty:QuestionDifficulty.easy200,questionAr:'على أي خور يقع حي الفهيدي التاريخي في دبي؟',questionEn:'Along which creek is Al Fahidi Historical Neighbourhood located?',answerAr:'خور دبي',answerEn:'Dubai Creek',sourceName:'Visit Dubai – Al Fahidi Historical Neighbourhood',sourceUrl:'https://www.visitdubai.com/en/places-to-visit/al-fahidi-historical-neighbourhood',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_084',categoryId:'uae_general',difficulty:QuestionDifficulty.hard600,questionAr:'قبل بناء أول جسر فوق خور دبي عام 1963، ما الوسيلة المستخدمة لعبور الخور؟',questionEn:'Before the first bridge over Dubai Creek was built in 1963, how was the creek crossed?',answerAr:'بالقوارب، ومنها العبرة',answerEn:'By boat, including abras',sourceName:'Visit Dubai – Dubai Creek facts',sourceUrl:'https://www.visitdubai.com/en/articles/things-you-didnt-know-about-dubai-creek',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_088',categoryId:'uae_general',difficulty:QuestionDifficulty.medium400,questionAr:'من صمم مبنى اللوفر أبوظبي؟',questionEn:'Who designed the Louvre Abu Dhabi building?',answerAr:'جان نوفيل',answerEn:'Jean Nouvel',sourceName:'Experience Abu Dhabi – Louvre Abu Dhabi',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/museums-and-art/louvre-abu-dhabi',lastVerified:DateTime(2026,9,28)),
  TriviaQuestion(id:'uae_general_089',categoryId:'uae_general',difficulty:QuestionDifficulty.hard600,questionAr:'كم يبلغ قطر قبة اللوفر أبوظبي؟',questionEn:'What is the diameter of Louvre Abu Dhabi’s dome?',answerAr:'180 متراً',answerEn:'180 metres',sourceName:'Experience Abu Dhabi – Louvre Abu Dhabi',sourceUrl:'https://visitabudhabi.ae/en/things-to-do/culture/museums-and-art/louvre-abu-dhabi',lastVerified:DateTime(2026,9,28)),
];
