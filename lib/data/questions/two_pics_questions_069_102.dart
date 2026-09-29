import '../question_model.dart';

TriviaQuestion _p600(String id,String ar,String en,String photo1,String photo2)=>TriviaQuestion(
 id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.hard600,
 questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,
 sourceName:'Original Two Pics Puzzle',sourceUrl:'internal://two-pics-v2',lastVerified:DateTime(2026,9,30),
 mediaType:QuestionMediaType.image,
 mediaAsset:'assets/two_pics/$id-1.webp',mediaAsset2:'assets/two_pics/$id-2.webp',
);

// 600-point puzzles use familiar Arabic phrases, idioms and compound concepts.
// They require an extra association step, but both photographs still provide fair clues.
final twoPicsQuestions069To102=<TriviaQuestion>[
_p600('two_pics_069','قلب من حجر','Heart of stone','realistic anatomical heart model on neutral background','rough heavy stone isolated in dramatic studio light'),
_p600('two_pics_070','إبرة في كومة قش','Needle in a haystack','single sewing needle macro photograph','large pile of dry hay in a barn'),
_p600('two_pics_071','هدوء ما قبل العاصفة','Calm before the storm','perfectly calm sea with still water','massive dark storm clouds approaching on horizon'),
_p600('two_pics_072','الوقت من ذهب','Time is gold','luxury analog clock face close-up','stack of polished gold bars'),
_p600('two_pics_073','دم بارد','Cold blood','red blood drop in clean medical-style macro photography','frost-covered block of ice'),
_p600('two_pics_074','ذاكرة السمكة','Fish memory','person concentrating with hand on temple, memory concept','goldfish swimming in clear aquarium'),
_p600('two_pics_075','صندوق أسود','Black box','closed matte-black box isolated in studio','commercial airplane photographed in flight'),
_p600('two_pics_076','حبل النجاة','Lifeline','thick rescue rope coiled close-up','person wearing life jacket floating safely in water'),
_p600('two_pics_077','كلمة السر','Password','human mouth speaking close-up, neutral portrait','secure padlock on digital login screen without readable text'),
_p600('two_pics_078','مفتاح النجاح','Key to success','antique metal key isolated on dark surface','person crossing a finish line with arms raised'),
_p600('two_pics_079','سلم النجاح','Ladder of success','tall ladder photographed from low angle','professional celebrating achievement at top of stairs'),
_p600('two_pics_080','طريق مسدود','Dead end','long empty road disappearing into distance','solid concrete barrier blocking passage'),
_p600('two_pics_081','فرصة ذهبية','Golden opportunity','open doorway with bright light beyond','single polished gold bar in premium studio lighting'),
_p600('two_pics_082','الجانب المظلم','Dark side','human face photographed clearly from the side','same visual idea represented by deep darkness and shadow'),
_p600('two_pics_083','نقطة تحول','Turning point','single black dot on clean white paper','sharp winding road making a dramatic hairpin turn'),
_p600('two_pics_084','كسر الروتين','Break the routine','broken chain link captured in close-up','identical daily calendar pages arranged repetitively'),
_p600('two_pics_085','خارج الصندوق','Outside the box','person standing clearly outside a large open cardboard box','geometric box isolated in minimal studio setting'),
_p600('two_pics_086','رأس الجبل','Mountain peak','human head profile in clean studio portrait','sharp mountain summit above clouds'),
_p600('two_pics_087','سفينة الصحراء','Ship of the desert','large ship sailing across open sea','camel walking across golden desert dunes'),
_p600('two_pics_088','بحر الرمال','Sea of sand','wide ocean waves reaching horizon','vast rolling desert dunes resembling waves'),
_p600('two_pics_089','خريطة الكنز','Treasure map','aged folded map with marked route but no readable words','open treasure chest filled with gold coins'),
_p600('two_pics_090','مفتاح المستقبل','Key to the future','metal key in futuristic studio lighting','futuristic smart city skyline at dusk'),
_p600('two_pics_091','جواهر التاج','Crown jewels','collection of precious gemstones close-up','royal crown on dark velvet'),
_p600('two_pics_092','تحت المجهر','Under the microscope','small object positioned beneath glass lens','laboratory microscope photographed side-on'),
_p600('two_pics_093','شعاع أمل','Ray of hope','single strong beam of sunlight through dark clouds','hopeful person looking toward bright horizon'),
_p600('two_pics_094','الاحتباس الحراري','Global warming','planet Earth globe photographed realistically','heat shimmer and rising thermometer concept without numbers'),
_p600('two_pics_095','ينبوع ساخن','Hot spring','natural freshwater spring emerging from rocks','visible steam rising from naturally hot water pool'),
_p600('two_pics_096','جدار الصمت','Wall of silence','tall concrete wall straight-on','person holding finger to lips in silence gesture'),
_p600('two_pics_097','ركوب الموجة','Ride the wave','surfer balanced on surfboard','large curling ocean wave close-up'),
_p600('two_pics_098','قفزة نوعية','Quantum leap','athlete captured mid-air in a powerful long jump','dramatic upward progress steps with one major jump, no text'),
_p600('two_pics_099','قمة الجليد','Tip of the iceberg','sharp mountain-like peak above horizon','massive iceberg showing small portion above ocean surface'),
_p600('two_pics_100','بومة الليل','Night owl','real owl perched with sharp eyes','modern city street photographed late at night'),
_p600('two_pics_101','خلل برمجي','Computer bug','real insect macro photograph','computer monitor showing generic code with warning symbol, no readable code'),
_p600('two_pics_102','شبكة العنكبوت','Spider web','real spider in macro photography','intricate dew-covered web filling the frame'),
];