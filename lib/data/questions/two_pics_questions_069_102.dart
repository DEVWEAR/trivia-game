import '../question_model.dart';
TriviaQuestion _p600(String id,String ar,String en,String photo1,String photo2){
 final n=int.parse(id.split('_').last);
 String localPhoto(int side)=>'assets/two_pics/redesign/${n.toString().padLeft(3,'0')}_$side.png';
 return TriviaQuestion(id:id,categoryId:'two_pics',difficulty:QuestionDifficulty.hard600,questionAr:'صورتان، عبارة واحدة',questionEn:'Two photos, one phrase',answerAr:ar,answerEn:en,sourceName:'Original generated clue artwork, visually reviewed',sourceUrl:'internal://original-clue-artwork',lastVerified:DateTime(2026,10,9),mediaType:QuestionMediaType.image,mediaAsset:localPhoto(1),mediaAsset2:localPhoto(2));
}
final twoPicsQuestions069To102=<TriviaQuestion>[
_p600('two_pics_069','قلب من حجر','Heart of stone','heart model','stone rock'),
_p600('two_pics_070','إبرة في كومة قش','Needle in a haystack','sewing needle','haystack'),
_p600('two_pics_071','هدوء ما قبل العاصفة','Calm before the storm','calm sea','storm clouds'),
_p600('two_pics_072','تأثير الفراشة','Butterfly effect','one beautiful butterfly perched on a bare twig, no storms or dominoes','a tiny ball nudging the first of a sequence of increasing-size plain blocks, the resulting falling sequence ends with a large block moving, no butterfly'),
_p600('two_pics_073','التحيز التأكيدي','Confirmation bias','a prominent green confirmation checkmark on an ivory round token, no scales or brain','a rigged balance scale visibly tilted by a thumb pressing on one pan despite equal matching weights, no checkmark'),
_p600('two_pics_074','رأس المال البشري','Human capital','a small diverse group of fictional skilled professionals: an engineer holding a ruler, a teacher with a book and a craftsperson with a tool, no money','a miniature factory beside stacks of generic gold investment coins, no humans, no heads'),
_p600('two_pics_075','معضلة السجين','Prisoner’s dilemma','one fictional adult prisoner behind plain vertical cell bars, dignified nonviolent scene, no other prisoner or choice symbols','a small fictional person facing a fork with two equal paths, each blocked by thorny barriers, visibly a difficult choice, no prison or bars'),
_p600('two_pics_076','حبل النجاة','Lifeline','rescue rope','life jacket'),
_p600('two_pics_077','كلمة السر','Password','mouth speaking','padlock login'),
_p600('two_pics_078','مفتاح النجاح','Key to success','metal key','finish line winner'),
_p600('two_pics_079','سلم النجاح','Ladder of success','ladder','success stairs'),
_p600('two_pics_080','مفارقة التوأم','Twin paradox','two identical fictional young adult siblings standing side by side in matching plain clothes, both the same age, no spaceship or clocks','a clean sculpted impossible Penrose triangle, clearly a visual logical paradox, no people or clocks'),
_p600('two_pics_081','فرصة ذهبية','Golden opportunity','open doorway','gold bar'),
_p600('two_pics_082','الجانب المظلم','Dark side','face side profile','dark shadow'),
_p600('two_pics_083','نقطة تحول','Turning point','black dot','sharp road turn'),
_p600('two_pics_084','كسر الروتين','Break the routine','broken chain','calendar routine'),
_p600('two_pics_085','خارج الصندوق','Outside the box','person outside box','cardboard box'),
_p600('two_pics_086','الكتلة الحرجة','Critical mass','a group of heavy metal spheres resting on a sturdy weighing scale, no alarm, no glowing nuclear material, no numbers','an urgent red warning beacon glowing above a pressure gauge whose needle has reached a red danger zone, no weighing scale or metal spheres, no words'),
_p600('two_pics_087','سفينة الصحراء','Ship of the desert','ship sea','camel desert'),
_p600('two_pics_088','الخلفية الكونية الميكروية','Cosmic microwave background','an unbranded microwave oven with its door closed and a clear simple control knob, no stars or space','a broad deep-space starfield backdrop with a graceful spiral galaxy in the distance, no appliance or radiation map'),
_p600('two_pics_089','التشابك الكمومي','Quantum entanglement','a sophisticated quantum-computing chip on a small circuit board under hanging cryogenic cables, no intertwined ropes or glowing paired particles','two contrasting teal and ivory ropes intricately intertwined in a clear loose knot, no chip or electronics'),
_p600('two_pics_090','التضخم الكوني','Cosmic inflation','a beautiful spiral galaxy in deep space, no balloon, no expansion arrows','a plain round balloon visibly being inflated by a small hand air pump, no stars or universe'),
_p600('two_pics_091','الانزياح الأحمر','Redshift','a pure red beam passing through an unlabelled red filter in a small studio optical setup, no galaxy or moving object','an ivory solid block displaced to the right from a clearly outlined previous position on a neutral track, one small motion arrow, no red, no light'),
_p600('two_pics_092','تحت المجهر','Under the microscope','specimen slide','microscope'),
_p600('two_pics_093','شعاع أمل','Ray of hope','sun ray clouds','hopeful horizon'),
_p600('two_pics_094','التوأم الرقمي','Digital twin','a glowing digital microchip with luminous binary zero-and-one patterns, no duplicate objects or people','two matching identical wooden mannequin figures side by side, no circuitry, no screens or holograms'),
_p600('two_pics_095','التشفير المتماثل','Symmetric encryption','a clean mathematical mirror-symmetry sculpture: three simple golden geometric solids on the left and their exactly matching mirrored counterparts on the right of a thin central vertical reflective panel, frontal view, equal distances from the panel, no butterflies, no insect, no lock or code','an envelope with scrambled abstract glyphs safely enclosed behind a small padlock, no reflected counterpart or duplicated keys, no readable words'),
_p600('two_pics_096','جدار الصمت','Wall of silence','concrete wall','silence gesture'),
_p600('two_pics_097','تصحيح الأخطاء بالبطة المطاطية','Rubber duck debugging','one cheerful plain yellow rubber bath duck, no computer, no programmer','a fictional programmer examining a laptop displaying abstract code-like lines, a magnifying glass highlights a red faulty line being changed to green, no insect, no duck, no readable text'),
_p600('two_pics_098','قفزة نوعية','Quantum leap','athlete jump','upward progress'),
_p600('two_pics_099','رأسمالية المراقبة','Surveillance capitalism','a generic security surveillance camera mounted on a short pole, no coins, bank or people','a miniature stock exchange scene with a simple rising market chart, generic gold coins and a bronze bull sculpture, no cameras, no data collection'),
_p600('two_pics_100','تأثير الهالة','Halo effect','a luminous golden halo ring floating above a simple neutral ivory sphere, no person, no rating symbols','one rolling ball striking a second ball which then moves away, a clear physical cause-and-effect scene, no halo or judgment symbols'),
_p600('two_pics_101','الدين التقني','Technical debt','a close view of a sophisticated unbranded electronic circuit board with an integrated microchip and fine traces, no money or warning icons','a fictional worried borrower at a desk with an empty wallet and a loan document, a small bank model and a stack of borrowed coins connected by a chain symbolize an outstanding debt, no electronic devices, no readable words'),
_p600('two_pics_102','الآلة الافتراضية','Virtual machine','a translucent luminous wireframe cube projected above a small hologram projector, clearly a simulated virtual object, no machine engine or computer desktop','a small detailed mechanical engine with gears and pistons, opaque solid metal, no hologram, no screens or computers'),
];
