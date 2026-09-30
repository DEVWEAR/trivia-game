import '../question_model.dart';
TriviaQuestion _p400(String id,String ar,String en,String photo1,String photo2){
 final n=int.parse(id.split('_').last);
 String localPhoto(int side)=>'assets/two_pics/${n.toString().padLeft(3,'0')}_$side.jpg';
 return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.medium400,questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,sourceName:'Bundled real photographic clue',sourceUrl:'local asset',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
}
final twoPicsQuestions035To068=<TriviaQuestion>[
_p400('two_pics_035','عصف ذهني','Brainstorm','human brain','storm clouds'),
_p400('two_pics_036','قمر صناعي','Satellite','moon','industrial factory'),
_p400('two_pics_037','عين الصقر','Eagle eye','human eye','eagle'),
_p400('two_pics_038','لسان البحر','Sea tongue','human tongue','sea'),
_p400('two_pics_039','بيت العنكبوت','Spider house','spider','house'),
_p400('two_pics_040','ساعة رملية','Hourglass','clock','sand'),
_p400('two_pics_041','موجة حر','Heat wave','ocean wave','hot sun'),
_p400('two_pics_042','كرة ثلج','Snowball','snow','ball'),
_p400('two_pics_043','وزن الريشة','Featherweight','heavy weight','feather'),
_p400('two_pics_044','طريق سريع','Highway','road','speedometer'),
_p400('two_pics_045','ضوء القمر','Moonlight','moon','light beam'),
_p400('two_pics_046','ماء الورد','Rose water','rose','water'),
_p400('two_pics_047','شجرة العائلة','Family tree','family','tree'),
_p400('two_pics_048','باب البحر','Sea gate','door','sea'),
_p400('two_pics_049','قلب الأسد','Lionheart','human heart','lion'),
_p400('two_pics_050','رأس المال','Capital','human head','money'),
_p400('two_pics_051','يد المساعدة','Helping hand','human hand','helping person'),
_p400('two_pics_052','عين الماء','Water spring','human eye','natural spring'),
_p400('two_pics_053','خط النار','Line of fire','straight line','fire'),
_p400('two_pics_054','جسر معلق','Suspension bridge','bridge','hanging rope'),
_p400('two_pics_055','كرسي كهربائي','Electric chair','chair','electric spark'),
_p400('two_pics_056','حائط الصد','Defensive wall','brick wall','goalkeeper blocking ball'),
_p400('two_pics_057','طاولة مستديرة','Round table','round circle','table'),
_p400('two_pics_058','مفتاح السيارة','Car key','metal key','car'),
_p400('two_pics_059','ضربة شمس','Sunstroke','boxing punch','bright sun'),
_p400('two_pics_060','حزام الأمان','Seat belt','clothing belt with buckle','safety shield symbol'),
_p400('two_pics_061','خط النهاية','Finish line','straight line','checkered finish flag'),
_p400('two_pics_062','سوق سوداء','Black market','market','black color'),
_p400('two_pics_063','البيت الأبيض','White House','house','white paint'),
_p400('two_pics_064','بحر ميت','Dead Sea','sea','dead dry tree'),
_p400('two_pics_065','كرة نارية','Fireball','fire','ball'),
_p400('two_pics_066','رجل أعمال','Businessman','adult man','business office'),
_p400('two_pics_067','ورقة نقدية','Banknote','paper sheet','money'),
_p400('two_pics_068','نجمة الصباح','Morning star','star','sunrise morning'),
];