import '../question_model.dart';

TriviaQuestion _p200(String id,String ar,String en,String photo1,String photo2){
  final n=int.parse(id.split('_').last);
  String localPhoto(int side)=>'assets/two_pics/${n.toString().padLeft(3,'0')}_$side.jpg';
  return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.easy200,questionAr:'صورتان، كلمة أو عبارة واحدة',questionEn:'Two pictures, one word or phrase',answerAr:ar,answerEn:en,sourceName:'Bundled real photographic clue',sourceUrl:'local asset',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
}
final twoPicsQuestions001To034=<TriviaQuestion>[
_p200('two_pics_001','نظارة شمسية','Sunglasses','bright sun sky','clear eyeglasses'),
_p200('two_pics_002','كرة القدم','Football','round sports ball','bare human foot'),
_p200('two_pics_003','نجم البحر','Starfish','five pointed star','tropical fish'),
_p200('two_pics_004','فرشاة أسنان','Toothbrush','white tooth dental','small cleaning brush'),
_p200('two_pics_005','معطف مطر','Raincoat','heavy rain','plain coat jacket'),
_p200('two_pics_006','حقيبة يد','Handbag','open human hand','plain bag with handles'),
_p200('two_pics_007','حصان البحر','Seahorse','blue sea ocean','horse animal'),
_p200('two_pics_008','رجل الثلج','Snowman','fresh white snow','adult man'),
_p200('two_pics_009','موقف حافلات','Bus stop','public transport stop sign','city bus'),
_p200('two_pics_010','سكة حديد','Railway','parallel steel rails','iron metal'),
_p200('two_pics_011','بيت الطيور','Birdhouse','small bird','small wooden house'),
_p200('two_pics_012','بيت الكلب','Doghouse','pet dog','small wooden house'),
_p200('two_pics_013','باب البيت','House door','wooden door','house exterior'),
_p200('two_pics_014','كرة سلة','Basketball','round sports ball','woven basket'),
_p200('two_pics_015','قلم رصاص','Pencil','writing pen','graphite lead'),
_p200('two_pics_016','حليب جوز الهند','Coconut milk','coconut fruit','glass of milk'),
_p200('two_pics_017','زهرة الشمس','Sunflower','bright sun','flower'),
_p200('two_pics_018','رأس السنة','New Year','human head','calendar new year'),
_p200('two_pics_019','ماء البحر','Seawater','clear water','blue sea'),
_p200('two_pics_020','ضوء الشمس','Sunlight','bright sun','beam of light'),
_p200('two_pics_021','حارس مرمى','Goalkeeper','security guard','football goal'),
_p200('two_pics_022','حذاء رياضي','Sports shoe','shoe','running track'),
_p200('two_pics_023','كتاب مفتوح','Open book','closed book','open doorway'),
_p200('two_pics_024','مفتاح باب','Door key','metal key','wooden door'),
_p200('two_pics_025','ساعة يد','Wristwatch','analog clock','human wrist'),
_p200('two_pics_026','كأس ماء','Glass of water','empty drinking glass','clear water'),
_p200('two_pics_027','طاولة طعام','Dining table','wooden table','meal plate'),
_p200('two_pics_028','كرة تنس','Tennis ball','round ball','tennis racket'),
_p200('two_pics_029','حبة رمل','Grain of sand','single grain macro','sand dunes'),
_p200('two_pics_030','راحة اليد','Palm of hand','resting person relaxing','open human hand'),
_p200('two_pics_031','قهوة عربية','Arabic coffee','coffee cup','Arabic dallah'),
_p200('two_pics_032','برج الساعة','Clock tower','tall tower','analog clock face'),
_p200('two_pics_033','ورق شجر','Tree leaves','paper sheets','green tree'),
_p200('two_pics_034','مفتاح بيت','House key','metal key','house exterior'),
];