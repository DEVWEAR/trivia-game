import '../question_model.dart';

TriviaQuestion _p200(String id,String ar,String en,String photo1,String photo2){
  final n=int.parse(id.split('_').last);
  String localPhoto(int side)=>'assets/two_pics/${n.toString().padLeft(3,'0')}_$side.jpg';
  return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.easy200,questionAr:'صورتان، كلمة أو عبارة واحدة',questionEn:'Two pictures, one word or phrase',answerAr:ar,answerEn:en,sourceName:'Bundled real photographic clue',sourceUrl:'local asset',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
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
_p200('two_pics_013','باب البيت','House door','door','house'),
_p200('two_pics_014','كرة سلة','Basketball','ball','basket'),
_p200('two_pics_015','قلم رصاص','Pencil','pen','lead graphite'),
_p200('two_pics_016','حليب جوز الهند','Coconut milk','coconut','milk'),
_p200('two_pics_017','زهرة الشمس','Sunflower','sun','flower'),
_p200('two_pics_018','سمك القرش','Shark','fish','shark'),
_p200('two_pics_019','ماء البحر','Seawater','water','sea'),
_p200('two_pics_020','ضوء الشمس','Sunlight','sun','light'),
_p200('two_pics_021','كرة طائرة','Volleyball','ball','volleyball'),
_p200('two_pics_022','حذاء رياضي','Sports shoe','shoe','sports'),
_p200('two_pics_023','كتاب مفتوح','Open book','book','open'),
_p200('two_pics_024','مفتاح باب','Door key','key','door'),
_p200('two_pics_025','ساعة يد','Wristwatch','watch','wrist'),
_p200('two_pics_026','كأس ماء','Glass of water','glass','water'),
_p200('two_pics_027','طاولة طعام','Dining table','table','food'),
_p200('two_pics_028','كرة تنس','Tennis ball','ball','tennis'),
_p200('two_pics_029','حبة رمل','Grain of sand','grain','sand'),
_p200('two_pics_030','شجرة نخيل','Palm tree','tree','palm'),
_p200('two_pics_031','قهوة عربية','Arabic coffee','coffee','Arabic dallah'),
_p200('two_pics_032','عين الشمس','Sun eye','eye','sun'),
_p200('two_pics_033','ورق شجر','Tree leaves','paper','tree leaves'),
_p200('two_pics_034','مفتاح بيت','House key','key','house'),
];