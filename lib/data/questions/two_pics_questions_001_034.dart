import '../question_model.dart';

TriviaQuestion _p200(String id,String ar,String en,String photo1,String photo2){
  final n=int.parse(id.split('_').last);
  String localPhoto(int side)=>'two_pics/${n.toString().padLeft(3,'0')}_$side.jpg';
  return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.easy200,questionAr:'صورتان، كلمة أو عبارة واحدة',questionEn:'Two pictures, one word or phrase',answerAr:ar,answerEn:en,sourceName:'Bundled real photographic clue',sourceUrl:'local web asset',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
}
final twoPicsQuestions001To034=<TriviaQuestion>[
_p200('two_pics_001','نظارة شمسية','Sunglasses','bright sun sky','eyeglasses sunglasses'),
_p200('two_pics_002','كرة القدم','Football','soccer football ball','human foot'),
_p200('two_pics_003','نجم البحر','Starfish','star shape','tropical fish'),
_p200('two_pics_004','فرشاة أسنان','Toothbrush','white tooth dental','toothbrush'),
_p200('two_pics_005','معطف مطر','Raincoat','heavy rain','coat jacket'),
_p200('two_pics_006','حقيبة يد','Handbag','human hand','handbag purse'),
_p200('two_pics_007','حصان البحر','Seahorse','blue sea ocean','horse animal'),
_p200('two_pics_008','رجل الثلج','Snowman','fresh snow','man portrait'),
_p200('two_pics_009','موقف حافلات','Bus stop','city bus','bus stop sign'),
_p200('two_pics_010','سكة حديد','Railway','train locomotive','railway tracks'),
_p200('two_pics_011','بيت الطيور','Birdhouse','small bird','wooden bird house'),
_p200('two_pics_012','بيت الكلب','Doghouse','dog pet','dog house kennel'),
_p200('two_pics_013','كيكة شوكولاتة','Chocolate cake','chocolate pieces','cake dessert'),
_p200('two_pics_014','عصير فراولة','Strawberry juice','fresh strawberry','glass fruit juice'),
_p200('two_pics_015','تشيز برجر','Cheeseburger','cheese slices','hamburger burger'),
_p200('two_pics_016','شوربة دجاج','Chicken soup','chicken food','soup bowl'),
_p200('two_pics_017','حليب بالشوكولاتة','Chocolate milk','glass milk','chocolate cocoa'),
_p200('two_pics_018','فطيرة تفاح','Apple pie','red apple','pie dessert'),
_p200('two_pics_019','كرة السلة','Basketball','basketball ball','basketball hoop'),
_p200('two_pics_020','كرة التنس','Tennis ball','tennis ball','tennis racket'),
_p200('two_pics_021','تنس الطاولة','Table tennis','table furniture','table tennis paddle'),
_p200('two_pics_022','حوض سباحة','Swimming pool','swimming pool water','swimmer swimming'),
_p200('two_pics_023','دراجة جبلية','Mountain bike','mountain landscape','mountain bicycle bike'),
_p200('two_pics_024','سباق سيارات','Car race','race car motorsport','finish line race'),
_p200('two_pics_025','مطار','Airport','passenger airplane','airport terminal'),
_p200('two_pics_026','مقهى','Coffee shop','coffee cup','cafe coffee shop'),
_p200('two_pics_027','غرفة نوم','Bedroom','bed furniture','bedroom interior'),
_p200('two_pics_028','غرفة طعام','Dining room','dining table','dining room interior'),
_p200('two_pics_029','مفتاح البيت','House key','house exterior','metal key'),
_p200('two_pics_030','شاطئ البحر','Seaside','blue sea ocean','sandy beach'),
_p200('two_pics_031','جبل جليدي','Iceberg','ice frozen','mountain peak'),
_p200('two_pics_032','سيارة إطفاء','Fire truck','fire flames','fire truck'),
_p200('two_pics_033','فشار','Popcorn','corn kernels','popcorn cinema'),
_p200('two_pics_034','ليمونادة','Lemonade','fresh lemon','lemonade glass'),
];