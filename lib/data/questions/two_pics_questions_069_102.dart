import '../question_model.dart';
TriviaQuestion _p600(String id,String ar,String en,String photo1,String photo2){
 final n=int.parse(id.split('_').last);
 String realPhoto(String brief,int side){final origin='https://loremflickr.com/960/720/${Uri.encodeComponent(brief)}?lock=${n*2+side}';return 'https://images.weserv.nl/?url=${Uri.encodeComponent(origin)}&w=960&h=720&fit=cover&output=jpg';}
 return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.hard600,questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,sourceName:'Real photographic clue feed via web-safe image proxy',sourceUrl:'https://images.weserv.nl/',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:realPhoto(photo1,0),mediaAsset2:realPhoto(photo2,1));
}
final twoPicsQuestions069To102=<TriviaQuestion>[
_p600('two_pics_069','قلب من حجر','Heart of stone','heart model','stone rock'),
_p600('two_pics_070','إبرة في كومة قش','Needle in a haystack','sewing needle','haystack'),
_p600('two_pics_071','هدوء ما قبل العاصفة','Calm before the storm','calm sea','storm clouds'),
_p600('two_pics_072','الوقت من ذهب','Time is gold','clock','gold bars'),
_p600('two_pics_073','دم بارد','Cold blood','blood drop','ice'),
_p600('two_pics_074','ذاكرة السمكة','Fish memory','person thinking','goldfish'),
_p600('two_pics_075','صندوق أسود','Black box','black box','airplane'),
_p600('two_pics_076','حبل النجاة','Lifeline','rescue rope','life jacket'),
_p600('two_pics_077','كلمة السر','Password','mouth speaking','padlock login'),
_p600('two_pics_078','مفتاح النجاح','Key to success','metal key','finish line winner'),
_p600('two_pics_079','سلم النجاح','Ladder of success','ladder','success stairs'),
_p600('two_pics_080','طريق مسدود','Dead end','road','road barrier'),
_p600('two_pics_081','فرصة ذهبية','Golden opportunity','open doorway','gold bar'),
_p600('two_pics_082','الجانب المظلم','Dark side','face side profile','dark shadow'),
_p600('two_pics_083','نقطة تحول','Turning point','black dot','sharp road turn'),
_p600('two_pics_084','كسر الروتين','Break the routine','broken chain','calendar routine'),
_p600('two_pics_085','خارج الصندوق','Outside the box','person outside box','cardboard box'),
_p600('two_pics_086','رأس الجبل','Mountain peak','human head','mountain peak'),
_p600('two_pics_087','سفينة الصحراء','Ship of the desert','ship sea','camel desert'),
_p600('two_pics_088','بحر الرمال','Sea of sand','ocean waves','sand dunes'),
_p600('two_pics_089','خريطة الكنز','Treasure map','old map','treasure chest'),
_p600('two_pics_090','مفتاح المستقبل','Key to the future','metal key','future city'),
_p600('two_pics_091','جواهر التاج','Crown jewels','gemstones','royal crown'),
_p600('two_pics_092','تحت المجهر','Under the microscope','specimen slide','microscope'),
_p600('two_pics_093','شعاع أمل','Ray of hope','sun ray clouds','hopeful horizon'),
_p600('two_pics_094','الاحتباس الحراري','Global warming','planet earth','thermometer heat'),
_p600('two_pics_095','ينبوع ساخن','Hot spring','water spring','steaming hot spring'),
_p600('two_pics_096','جدار الصمت','Wall of silence','concrete wall','silence gesture'),
_p600('two_pics_097','ركوب الموجة','Ride the wave','surfer','ocean wave'),
_p600('two_pics_098','قفزة نوعية','Quantum leap','athlete jump','upward progress'),
_p600('two_pics_099','قمة الجليد','Tip of the iceberg','mountain peak','iceberg'),
_p600('two_pics_100','بومة الليل','Night owl','owl','city night'),
_p600('two_pics_101','خلل برمجي','Computer bug','insect','computer error'),
_p600('two_pics_102','شبكة العنكبوت','Spider web','spider','spider web'),
];