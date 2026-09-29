import '../question_model.dart';
TriviaQuestion _p400(String id,String ar,String en,String photo1,String photo2){
 final n=int.parse(id.split('_').last);
 String realPhoto(String brief,int side){final origin='https://loremflickr.com/960/720/${Uri.encodeComponent(brief)}?lock=${n*2+side}';return 'https://images.weserv.nl/?url=${Uri.encodeComponent(origin)}&w=960&h=720&fit=cover&output=jpg';}
 return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.medium400,questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,sourceName:'Real photographic clue feed via web-safe image proxy',sourceUrl:'https://images.weserv.nl/',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:realPhoto(photo1,0),mediaAsset2:realPhoto(photo2,1));
}
final twoPicsQuestions035To068=<TriviaQuestion>[
_p400('two_pics_035','عصف ذهني','Brainstorm','human brain anatomy model','thunderstorm dark clouds'),
_p400('two_pics_036','قلب من ذهب','Heart of gold','human heart anatomy model','gold bars bullion'),
_p400('two_pics_037','قنبلة موقوتة','Time bomb','vintage clock timer','bomb movie prop'),
_p400('two_pics_038','دموع التماسيح','Crocodile tears','crocodile face','human tear cheek'),
_p400('two_pics_039','لسان البحر','Sea tongue','human tongue','narrow sea inlet coast'),
_p400('two_pics_040','عين العاصفة','Eye of the storm','human eye macro','hurricane eye satellite'),
_p400('two_pics_041','بيت العنكبوت','Spider house','modern house exterior','spider web macro'),
_p400('two_pics_042','ذاكرة حديدية','Iron memory','iron metal bars','person thinking remembering'),
_p400('two_pics_043','رأس الخيط','Thread beginning','human head profile','thread spool loose end'),
_p400('two_pics_044','سيف ذو حدين','Double-edged sword','decorative sword','double edged blade macro'),
_p400('two_pics_045','ملك الغابة','King of the jungle','royal gold crown','lion savanna'),
_p400('two_pics_046','بحر من الناس','Sea of people','blue ocean horizon','large crowd aerial'),
_p400('two_pics_047','خريطة العالم','World map','paper map','planet earth space'),
_p400('two_pics_048','سفينة فضاء','Spaceship','ship ocean','spacecraft earth'),
_p400('two_pics_049','المشي على القمر','Moonwalk','walking boots footprints','full moon night'),
_p400('two_pics_050','عباد الشمس','Sunflower','bright sun sky','sunflower field'),
_p400('two_pics_051','قوس قزح','Rainbow','architecture arch','rain drops sunlight'),
_p400('two_pics_052','عاصفة رملية','Sandstorm','wind storm clouds','desert sand dunes'),
_p400('two_pics_053','كرة ثلج','Snowball','fresh white snow','round ball'),
_p400('two_pics_054','جدار ناري','Firewall','brick wall','fire flames'),
_p400('two_pics_055','بصمة رقمية','Digital fingerprint','fingerprint scanner','binary digital screen'),
_p400('two_pics_056','ساعة ذكية','Smartwatch','wrist watch','computer chip technology'),
_p400('two_pics_057','فأرة الكمبيوتر','Computer mouse','mouse animal','desktop computer'),
_p400('two_pics_058','موجة صوتية','Sound wave','ocean wave','microphone audio waveform'),
_p400('two_pics_059','واقع افتراضي','Virtual reality','real city street','virtual reality headset'),
_p400('two_pics_060','سيارة كهربائية','Electric car','modern car','electric lightning'),
_p400('two_pics_061','طاقة شمسية','Solar energy','electric energy sparks','bright sun'),
_p400('two_pics_062','ذكاء اصطناعي','Artificial intelligence','human brain','humanoid robot face'),
_p400('two_pics_063','محفظة إلكترونية','Digital wallet','leather wallet','smartphone contactless payment'),
_p400('two_pics_064','قفل الشاشة','Screen lock','metal padlock','smartphone screen'),
_p400('two_pics_065','تخزين سحابي','Cloud storage','storage boxes warehouse','white cloud sky'),
_p400('two_pics_066','صندوق الوارد','Inbox','open wooden box','mail letters'),
_p400('two_pics_067','سوق إلكتروني','Online marketplace','traditional market souq','laptop online shopping'),
_p400('two_pics_068','بنك إلكتروني','Digital bank','bank building','smartphone banking'),
];