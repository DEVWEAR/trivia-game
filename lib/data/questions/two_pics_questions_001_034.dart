import '../question_model.dart';

TriviaQuestion _p200(
  String id,
  String ar,
  String en,
  String photo1,
  String photo2,
)=>TriviaQuestion(
  id:id,
  categoryId:'two_pics',
  difficulty:QuestionDifficulty.easy200,
  questionAr:'صورتان، كلمة أو عبارة واحدة',
  questionEn:'Two pictures, one word or phrase',
  answerAr:ar,
  answerEn:en,
  sourceName:'DEV original visual puzzle',
  sourceUrl:'internal://two-pics-v2',
  lastVerified:DateTime(2026,9,30),
  mediaType:QuestionMediaType.image,
  mediaAsset:'assets/two_pics/$id-a.jpg',
  mediaAsset2:'assets/two_pics/$id-b.jpg',
);

/// PHOTO BRIEFS (for production assets):
/// 001 sun / eyeglasses -> نظارة شمسية
/// 002 football / human foot -> كرة القدم
/// 003 sea star / tropical fish -> نجم البحر
/// 004 tooth / toothbrush -> فرشاة أسنان
/// 005 rain / coat -> معطف مطر
/// 006 hand / handbag -> حقيبة يد
/// 007 sea / horse -> حصان البحر
/// 008 snow / man -> رجل الثلج
/// 009 bus / stop sign -> موقف حافلات
/// 010 train / steel rail tracks -> سكة حديد
/// 011 bird / small wooden house -> بيت الطيور
/// 012 dog / dog house -> بيت الكلب
/// 013 chocolate / cake -> كيكة شوكولاتة
/// 014 strawberry / glass of juice -> عصير فراولة
/// 015 cheese / burger -> تشيز برجر
/// 016 chicken / soup bowl -> شوربة دجاج
/// 017 milk / chocolate -> حليب بالشوكولاتة
/// 018 apple / pie -> فطيرة تفاح
/// 019 basketball / hoop -> كرة السلة
/// 020 tennis ball / racket -> كرة التنس
/// 021 table / tennis paddle -> تنس الطاولة
/// 022 swimming pool / swimmer -> حوض سباحة
/// 023 mountain / bicycle -> دراجة جبلية
/// 024 race car / finish line -> سباق سيارات
/// 025 airplane / airport terminal -> مطار
/// 026 coffee cup / cafe storefront -> مقهى
/// 027 bedroom bed / room interior -> غرفة نوم
/// 028 dining table / dining room -> غرفة طعام
/// 029 house / key -> مفتاح البيت
/// 030 sea / beach -> شاطئ البحر
/// 031 ice / mountain -> جبل جليدي
/// 032 fire / firefighter truck -> سيارة إطفاء
/// 033 popcorn kernels / cinema popcorn -> فشار
/// 034 lemon / cold lemonade glass -> ليمونادة
final twoPicsQuestions001To034=<TriviaQuestion>[
_p200('two_pics_001','نظارة شمسية','Sunglasses','sun','eyeglasses'),
_p200('two_pics_002','كرة القدم','Football','football','foot'),
_p200('two_pics_003','نجم البحر','Starfish','star','fish'),
_p200('two_pics_004','فرشاة أسنان','Toothbrush','tooth','toothbrush'),
_p200('two_pics_005','معطف مطر','Raincoat','rain','coat'),
_p200('two_pics_006','حقيبة يد','Handbag','hand','handbag'),
_p200('two_pics_007','حصان البحر','Seahorse','sea','horse'),
_p200('two_pics_008','رجل الثلج','Snowman','snow','man'),
_p200('two_pics_009','موقف حافلات','Bus stop','bus','stop'),
_p200('two_pics_010','سكة حديد','Railway','train','rail'),
_p200('two_pics_011','بيت الطيور','Birdhouse','bird','house'),
_p200('two_pics_012','بيت الكلب','Doghouse','dog','house'),
_p200('two_pics_013','كيكة شوكولاتة','Chocolate cake','chocolate','cake'),
_p200('two_pics_014','عصير فراولة','Strawberry juice','strawberry','juice'),
_p200('two_pics_015','تشيز برجر','Cheeseburger','cheese','burger'),
_p200('two_pics_016','شوربة دجاج','Chicken soup','chicken','soup'),
_p200('two_pics_017','حليب بالشوكولاتة','Chocolate milk','milk','chocolate'),
_p200('two_pics_018','فطيرة تفاح','Apple pie','apple','pie'),
_p200('two_pics_019','كرة السلة','Basketball','basketball','hoop'),
_p200('two_pics_020','كرة التنس','Tennis ball','tennis ball','racket'),
_p200('two_pics_021','تنس الطاولة','Table tennis','table','tennis paddle'),
_p200('two_pics_022','حوض سباحة','Swimming pool','pool','swimmer'),
_p200('two_pics_023','دراجة جبلية','Mountain bike','mountain','bicycle'),
_p200('two_pics_024','سباق سيارات','Car race','race car','finish line'),
_p200('two_pics_025','مطار','Airport','airplane','terminal'),
_p200('two_pics_026','مقهى','Coffee shop','coffee','cafe'),
_p200('two_pics_027','غرفة نوم','Bedroom','bed','room'),
_p200('two_pics_028','غرفة طعام','Dining room','dining table','room'),
_p200('two_pics_029','مفتاح البيت','House key','house','key'),
_p200('two_pics_030','شاطئ البحر','Seaside','sea','beach'),
_p200('two_pics_031','جبل جليدي','Iceberg','ice','mountain'),
_p200('two_pics_032','سيارة إطفاء','Fire truck','fire','fire truck'),
_p200('two_pics_033','فشار','Popcorn','corn kernels','popcorn'),
_p200('two_pics_034','ليمونادة','Lemonade','lemon','lemonade'),
];
