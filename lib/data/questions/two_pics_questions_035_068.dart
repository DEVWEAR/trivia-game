import '../question_model.dart';
TriviaQuestion _p400(String id,String ar,String en,String photo1,String photo2){
 final n=int.parse(id.split('_').last);
 String localPhoto(int side)=>'two_pics/${n.toString().padLeft(3,'0')}_$side.jpg';
 return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.medium400,questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,sourceName:'Bundled Wikimedia Commons photographic clue',sourceUrl:'https://commons.wikimedia.org/',lastVerified:DateTime(2026,9,30),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
}
final twoPicsQuestions035To068=<TriviaQuestion>[
_p400('two_pics_035','عصف ذهني','Brainstorm','human brain anatomy model','thunderstorm dark clouds'),
_p400('two_pics_036','قمر صناعي','Satellite','moon night','satellite space'),
_p400('two_pics_037','عين الصقر','Eagle eye','human eye closeup','eagle bird'),
_p400('two_pics_038','لسان البحر','Sea tongue','human tongue','sea coast'),
_p400('two_pics_039','بيت العنكبوت','Spider house','spider web','house exterior'),
_p400('two_pics_040','ساعة رملية','Hourglass','clock watch','sand dunes'),
_p400('two_pics_041','موجة حر','Heat wave','ocean wave','hot sun'),
_p400('two_pics_042','كرة ثلج','Snowball','snow winter','ball sphere'),
_p400('two_pics_043','مطرقة ثقيلة','Heavy hammer','hammer tool','heavy weight'),
_p400('two_pics_044','طريق سريع','Highway','road highway','speedometer fast'),
_p400('two_pics_045','ضوء القمر','Moonlight','moon night','light beam'),
_p400('two_pics_046','ماء الورد','Rose water','rose flower','water glass'),
_p400('two_pics_047','شجرة العائلة','Family tree','family portrait','tree branches'),
_p400('two_pics_048','باب البحر','Sea gate','door gate','sea ocean'),
_p400('two_pics_049','قلب الأسد','Lionheart','human heart model','lion animal'),
_p400('two_pics_050','رأس المال','Capital','human head','money banknotes'),
_p400('two_pics_051','يد المساعدة','Helping hand','human hand','helping people'),
_p400('two_pics_052','عين الماء','Water spring','human eye','water spring nature'),
_p400('two_pics_053','خط النار','Line of fire','straight line','fire flames'),
_p400('two_pics_054','جسر معلق','Suspension bridge','bridge','hanging rope'),
_p400('two_pics_055','كرسي كهربائي','Electric chair','chair furniture','electric lightning'),
_p400('two_pics_056','حائط الصد','Defensive wall','brick wall','football goalkeeper'),
_p400('two_pics_057','طاولة مستديرة','Round table','round circle','table furniture'),
_p400('two_pics_058','مفتاح السيارة','Car key','metal key','car automobile'),
_p400('two_pics_059','ضربة شمس','Sunstroke','bright sun','person headache'),
_p400('two_pics_060','حزام الأمان','Seat belt','belt','car seat'),
_p400('two_pics_061','خط النهاية','Finish line','line marking','race finish'),
_p400('two_pics_062','سوق سوداء','Black market','market stalls','black color'),
_p400('two_pics_063','البيت الأبيض','White House','white house building','USA flag'),
_p400('two_pics_064','بحر ميت','Dead Sea','sea water','dead tree'),
_p400('two_pics_065','كرة نارية','Fireball','fire flames','ball sphere'),
_p400('two_pics_066','رجل أعمال','Businessman','man portrait','office business'),
_p400('two_pics_067','ورقة نقدية','Banknote','paper sheet','money banknotes'),
_p400('two_pics_068','نجمة الصباح','Morning star','star sky','sunrise morning'),
];