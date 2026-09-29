import '../question_model.dart';

TriviaQuestion _p400(String id,String ar,String en,String photo1,String photo2)=>TriviaQuestion(
 id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.medium400,
 questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,
 sourceName:'Original Two Pics Puzzle',sourceUrl:'internal://two-pics-v2',lastVerified:DateTime(2026,9,30),
 mediaType:QuestionMediaType.image,
 mediaAsset:'assets/two_pics/$id-1.webp',mediaAsset2:'assets/two_pics/$id-2.webp',
);

// Photo briefs are deliberately literal enough to be fair, while the relationship
// between them requires a second step of thinking. No emoji or arbitrary rebus logic.
final twoPicsQuestions035To068=<TriviaQuestion>[
_p400('two_pics_035','عصف ذهني','Brainstorm','close-up human brain anatomy model','dramatic wind storm over open landscape'),
_p400('two_pics_036','قلب من ذهب','Heart of gold','realistic anatomical heart model','polished gold bars in studio light'),
_p400('two_pics_037','قنبلة موقوتة','Time bomb','vintage ticking clock close-up','cinematic inert bomb prop with wires, no instructions'),
_p400('two_pics_038','دموع التماسيح','Crocodile tears','real crocodile face close-up','single tear rolling down a human cheek'),
_p400('two_pics_039','لسان البحر','Sea tongue','human tongue close-up, clean neutral portrait','aerial view of a narrow sea inlet reaching into land'),
_p400('two_pics_040','عين العاصفة','Eye of the storm','sharp macro photograph of a human eye','satellite-style photograph of hurricane eye'),
_p400('two_pics_041','بيت العنكبوت','Spider house','modern small house exterior','real spider on a detailed web'),
_p400('two_pics_042','ذاكرة حديدية','Iron memory','stack of iron metal bars','person concentrating while recalling something, memory concept'),
_p400('two_pics_043','رأس الخيط','Thread beginning','close-up human head profile','macro photograph of loose end of a spool of thread'),
_p400('two_pics_044','سيف ذو حدين','Double-edged sword','real decorative sword isolated in studio','macro view showing two sharpened edges of a blade'),
_p400('two_pics_045','ملك الغابة','King of the jungle','royal gold crown on velvet','majestic lion standing in wild savanna'),
_p400('two_pics_046','بحر من الناس','Sea of people','wide blue ocean horizon','huge dense crowd photographed from above'),
_p400('two_pics_047','خريطة العالم','World map','folded paper map close-up','planet Earth photographed from space'),
_p400('two_pics_048','سفينة فضاء','Spaceship','large passenger ship at sea','realistic spacecraft above Earth'),
_p400('two_pics_049','المشي على القمر','Moonwalk','boots walking with visible footprints','detailed full moon in dark sky'),
_p400('two_pics_050','عباد الشمس','Sunflower','bright sun in clear sky','field of real sunflowers facing sunlight'),
_p400('two_pics_051','قوس قزح','Rainbow','traditional arch shape in architecture','rain droplets falling in sunlight'),
_p400('two_pics_052','عاصفة رملية','Sandstorm','powerful storm clouds with wind','close-up golden desert sand dunes'),
_p400('two_pics_053','كرة ثلج','Snowball','clean white snow field close-up','round sports ball isolated in studio'),
_p400('two_pics_054','جدار ناري','Firewall','brick wall photographed straight on','large controlled fireplace flames close-up'),
_p400('two_pics_055','بصمة رقمية','Digital fingerprint','macro human fingerprint on scanner','glowing digital binary data on screen'),
_p400('two_pics_056','ساعة ذكية','Smartwatch','classic wristwatch on wrist','modern AI chip and connected circuitry'),
_p400('two_pics_057','فأرة الكمبيوتر','Computer mouse','real small mouse animal in clean setting','desktop computer on modern desk'),
_p400('two_pics_058','موجة صوتية','Sound wave','ocean wave frozen at peak','studio microphone with visible audio waveform display'),
_p400('two_pics_059','واقع افتراضي','Virtual reality','real city street photographed naturally','person wearing modern VR headset'),
_p400('two_pics_060','سيارة كهربائية','Electric car','modern car photographed side-on','bright electric lightning bolt concept, no text'),
_p400('two_pics_061','طاقة شمسية','Solar energy','high-voltage energy sparks in safe abstract visualization','sun shining brightly in clear sky'),
_p400('two_pics_062','ذكاء اصطناعي','Artificial intelligence','human brain scan visualization','sleek humanoid robot face in realistic studio photography'),
_p400('two_pics_063','محفظة إلكترونية','Digital wallet','leather wallet with cards and cash','smartphone showing generic contactless payment screen without logos'),
_p400('two_pics_064','قفل الشاشة','Screen lock','metal padlock close-up','smartphone screen photographed front-on'),
_p400('two_pics_065','تخزين سحابي','Cloud storage','warehouse shelves full of storage boxes','dramatic white cloud in blue sky'),
_p400('two_pics_066','صندوق الوارد','Inbox','wooden open box viewed from above','letters arriving through a mail slot'),
_p400('two_pics_067','سوق إلكتروني','Online marketplace','busy traditional Gulf market stalls','laptop displaying generic shopping storefront without brands'),
_p400('two_pics_068','بنك إلكتروني','Digital bank','modern bank building exterior without branding','smartphone with generic secure finance interface without text'),
];