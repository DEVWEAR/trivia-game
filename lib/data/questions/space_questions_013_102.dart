import '../question_model.dart';

TriviaQuestion _spaceQ(String id, QuestionDifficulty d, String ar, String en, String aa, String ae, String url) => TriviaQuestion(id:id,categoryId:'space',difficulty:d,questionAr:ar,questionEn:en,answerAr:aa,answerEn:ae,sourceName:'NASA Science',sourceUrl:url,lastVerified:DateTime(2026,9,29));

const _planets='https://science.nasa.gov/solar-system/planets/';
const _mercury='https://science.nasa.gov/mercury/facts/';
const _venus='https://science.nasa.gov/venus/venus-facts/';
const _earth='https://science.nasa.gov/earth/facts/';
const _moon='https://science.nasa.gov/moon/facts/';
const _mars='https://science.nasa.gov/mars/facts/';
const _marsMoons='https://science.nasa.gov/mars/moons/facts/';
const _jupiter='https://science.nasa.gov/jupiter/jupiter-facts/';
const _saturn='https://science.nasa.gov/saturn/facts/';
const _uranus='https://science.nasa.gov/uranus/facts/';
const _neptune='https://science.nasa.gov/neptune/neptune-facts/';
const _sun='https://science.nasa.gov/sun/facts/';
const _pluto='https://science.nasa.gov/dwarf-planets/pluto/facts/';
const _ceres='https://science.nasa.gov/dwarf-planets/ceres/facts/';
const _asteroids='https://science.nasa.gov/solar-system/asteroids/facts/';
const _comets='https://science.nasa.gov/solar-system/comets/facts/';
const _galaxy='https://science.nasa.gov/universe/galaxies/';
const _stars='https://science.nasa.gov/universe/stars/';

/// Space questions 013–102. Together with 001–012 this yields exactly
/// 34 easy (200), 34 medium (400), and 34 hard (600) questions.
final spaceQuestions013To102=<TriviaQuestion>[
// 200 — 30 questions
_spaceQ('space_013',QuestionDifficulty.easy200,'ما الكوكب المعروف بالكوكب الأحمر؟','Which planet is known as the Red Planet?','المريخ','Mars',_mars),
_spaceQ('space_014',QuestionDifficulty.easy200,'ما الكوكب الثاني من الشمس؟','Which planet is second from the Sun?','الزهرة','Venus',_venus),
_spaceQ('space_015',QuestionDifficulty.easy200,'ما الكوكب الثالث من الشمس؟','Which planet is third from the Sun?','الأرض','Earth',_earth),
_spaceQ('space_016',QuestionDifficulty.easy200,'ما الكوكب الرابع من الشمس؟','Which planet is fourth from the Sun?','المريخ','Mars',_mars),
_spaceQ('space_017',QuestionDifficulty.easy200,'ما الكوكب الخامس من الشمس؟','Which planet is fifth from the Sun?','المشتري','Jupiter',_jupiter),
_spaceQ('space_018',QuestionDifficulty.easy200,'ما الكوكب السادس من الشمس؟','Which planet is sixth from the Sun?','زحل','Saturn',_saturn),
_spaceQ('space_019',QuestionDifficulty.easy200,'ما الكوكب السابع من الشمس؟','Which planet is seventh from the Sun?','أورانوس','Uranus',_uranus),
_spaceQ('space_020',QuestionDifficulty.easy200,'أي كوكب يشتهر بحلقاته البارزة؟','Which planet is famous for its prominent rings?','زحل','Saturn',_saturn),
_spaceQ('space_021',QuestionDifficulty.easy200,'ما أكثر كواكب النظام الشمسي حرارة؟','What is the hottest planet in the solar system?','الزهرة','Venus',_venus),
_spaceQ('space_022',QuestionDifficulty.easy200,'ما اسم قمر الأرض الطبيعي؟','What is Earth’s natural satellite called?','القمر','The Moon',_moon),
_spaceQ('space_023',QuestionDifficulty.easy200,'كم قمراً للمريخ؟','How many moons does Mars have?','قمران','Two',_marsMoons),
_spaceQ('space_024',QuestionDifficulty.easy200,'ما اسما قمري المريخ؟','What are the names of Mars’ two moons?','فوبوس وديموس','Phobos and Deimos',_marsMoons),
_spaceQ('space_025',QuestionDifficulty.easy200,'ما أكبر قمر في النظام الشمسي؟','What is the largest moon in the solar system?','غانيميد','Ganymede',_jupiter),
_spaceQ('space_026',QuestionDifficulty.easy200,'حول أي كوكب يدور غانيميد؟','Which planet does Ganymede orbit?','المشتري','Jupiter',_jupiter),
_spaceQ('space_027',QuestionDifficulty.easy200,'أي قمر للمشتري يُعد أكثر الأجرام نشاطاً بركانياً؟','Which moon of Jupiter is the most volcanically active body?','آيو','Io',_jupiter),
_spaceQ('space_028',QuestionDifficulty.easy200,'ما اسم البقعة العاصفية الشهيرة على المشتري؟','What is Jupiter’s famous giant storm called?','البقعة الحمراء العظيمة','The Great Red Spot',_jupiter),
_spaceQ('space_029',QuestionDifficulty.easy200,'أي كوكب يملك أقصر يوم في النظام الشمسي؟','Which planet has the shortest day in the solar system?','المشتري','Jupiter',_jupiter),
_spaceQ('space_030',QuestionDifficulty.easy200,'كم يستغرق يوم المشتري تقريباً؟','About how long is a day on Jupiter?','9.9 ساعات تقريباً','About 9.9 hours',_jupiter),
_spaceQ('space_031',QuestionDifficulty.easy200,'كم يستغرق عطارد لإكمال دورة حول الشمس؟','How long does Mercury take to orbit the Sun?','88 يوماً أرضياً','88 Earth days',_mercury),
_spaceQ('space_032',QuestionDifficulty.easy200,'هل يملك عطارد حلقات؟','Does Mercury have rings?','لا','No',_mercury),
_spaceQ('space_033',QuestionDifficulty.easy200,'هل يملك المريخ حلقات حالياً؟','Does Mars currently have rings?','لا','No',_mars),
_spaceQ('space_034',QuestionDifficulty.easy200,'ما النجم الموجود في مركز نظامنا الشمسي؟','What star is at the center of our solar system?','الشمس','The Sun',_sun),
_spaceQ('space_035',QuestionDifficulty.easy200,'ما المجرة التي يقع فيها نظامنا الشمسي؟','Which galaxy contains our solar system?','درب التبانة','The Milky Way',_galaxy),
_spaceQ('space_036',QuestionDifficulty.easy200,'ما الكوكب القزم الذي كان يُعد الكوكب التاسع سابقاً؟','Which dwarf planet was formerly considered the ninth planet?','بلوتو','Pluto',_pluto),
_spaceQ('space_037',QuestionDifficulty.easy200,'أين يقع حزام الكويكبات الرئيسي؟','Where is the main asteroid belt located?','بين المريخ والمشتري','Between Mars and Jupiter',_asteroids),
_spaceQ('space_038',QuestionDifficulty.easy200,'ما أكبر جسم في حزام الكويكبات الرئيسي؟','What is the largest object in the main asteroid belt?','سيريس','Ceres',_ceres),
_spaceQ('space_039',QuestionDifficulty.easy200,'ما الغاز الأكثر وفرة في الشمس؟','What is the most abundant gas in the Sun?','الهيدروجين','Hydrogen',_sun),
_spaceQ('space_040',QuestionDifficulty.easy200,'ما ثاني أكثر عنصر وفرة في الشمس؟','What is the second most abundant element in the Sun?','الهيليوم','Helium',_sun),
_spaceQ('space_041',QuestionDifficulty.easy200,'أي كوكب يدور على جانبه تقريباً؟','Which planet rotates nearly on its side?','أورانوس','Uranus',_uranus),
_spaceQ('space_042',QuestionDifficulty.easy200,'أي كوكب أزرق بعيد سُمّي نسبةً إلى إله البحر الروماني؟','Which distant blue planet was named for the Roman god of the sea?','نبتون','Neptune',_neptune),

// 400 — 30 questions
_spaceQ('space_043',QuestionDifficulty.medium400,'كم يستغرق دوران عطارد حول محوره تقريباً؟','About how long does Mercury take to rotate once?','59 يوماً أرضياً','About 59 Earth days',_mercury),
_spaceQ('space_044',QuestionDifficulty.medium400,'كم يبلغ طول اليوم الشمسي على عطارد؟','How long is one solar day on Mercury?','176 يوماً أرضياً','176 Earth days',_mercury),
_spaceQ('space_045',QuestionDifficulty.medium400,'كم يستغرق عام الزهرة تقريباً؟','About how long is a year on Venus?','225 يوماً أرضياً','About 225 Earth days',_venus),
_spaceQ('space_046',QuestionDifficulty.medium400,'كم يستغرق دوران الزهرة حول محوره تقريباً؟','About how long does Venus take to rotate once?','243 يوماً أرضياً','About 243 Earth days',_venus),
_spaceQ('space_047',QuestionDifficulty.medium400,'من أي جهة تشرق الشمس على الزهرة بسبب دورانه العكسي؟','From which direction would the Sun rise on Venus because of its retrograde rotation?','من الغرب','From the west',_venus),
_spaceQ('space_048',QuestionDifficulty.medium400,'ما الغاز الرئيسي في الغلاف الجوي للزهرة؟','What is the main gas in Venus’ atmosphere?','ثاني أكسيد الكربون','Carbon dioxide',_venus),
_spaceQ('space_049',QuestionDifficulty.medium400,'كم يبلغ ضغط سطح الزهرة تقريباً مقارنةً بسطح الأرض؟','About how many times Earth sea-level pressure is the surface pressure on Venus?','نحو 93 مرة','About 93 times',_venus),
_spaceQ('space_050',QuestionDifficulty.medium400,'كم يستغرق اليوم على المريخ تقريباً؟','About how long is a day on Mars?','24.6 ساعة','24.6 hours',_mars),
_spaceQ('space_051',QuestionDifficulty.medium400,'كم يستغرق العام على المريخ بالأيام الأرضية؟','How long is a Martian year in Earth days?','687 يوماً أرضياً','687 Earth days',_mars),
_spaceQ('space_052',QuestionDifficulty.medium400,'ما سبب اللون الأحمر للمريخ؟','What causes Mars’ reddish color?','أكسدة معادن الحديد (الصدأ)','Oxidation of iron minerals (rust)',_mars),
_spaceQ('space_053',QuestionDifficulty.medium400,'ما أكبر بركان في النظام الشمسي؟','What is the largest volcano in the solar system?','أوليمبوس مونس','Olympus Mons',_mars),
_spaceQ('space_054',QuestionDifficulty.medium400,'من اكتشف قمري المريخ عام 1877؟','Who discovered Mars’ moons in 1877?','آساف هول','Asaph Hall',_marsMoons),
_spaceQ('space_055',QuestionDifficulty.medium400,'أي قمري المريخ أكبر: فوبوس أم ديموس؟','Which Mars moon is larger: Phobos or Deimos?','فوبوس','Phobos',_marsMoons),
_spaceQ('space_056',QuestionDifficulty.medium400,'كم مرة يدور فوبوس حول المريخ تقريباً في اليوم؟','About how many times does Phobos orbit Mars each day?','ثلاث مرات','Three times',_marsMoons),
_spaceQ('space_057',QuestionDifficulty.medium400,'كم يستغرق ديموس تقريباً لإكمال مداره حول المريخ؟','About how long does Deimos take to orbit Mars?','30 ساعة','30 hours',_marsMoons),
_spaceQ('space_058',QuestionDifficulty.medium400,'ما أسماء الأقمار الجليلية الأربعة للمشتري؟','What are Jupiter’s four Galilean moons?','آيو، أوروبا، غانيميد، كاليستو','Io, Europa, Ganymede, and Callisto',_jupiter),
_spaceQ('space_059',QuestionDifficulty.medium400,'من رصد الأقمار الجليلية الأربعة عام 1610؟','Who observed the four Galilean moons in 1610?','غاليليو غاليلي','Galileo Galilei',_jupiter),
_spaceQ('space_060',QuestionDifficulty.medium400,'كم يستغرق عام المشتري تقريباً بالسنوات الأرضية؟','About how long is a year on Jupiter in Earth years?','نحو 12 سنة أرضية','About 12 Earth years',_jupiter),
_spaceQ('space_061',QuestionDifficulty.medium400,'ما الغازان الرئيسيان في الغلاف الجوي للمشتري؟','What are the two main gases in Jupiter’s atmosphere?','الهيدروجين والهيليوم','Hydrogen and helium',_jupiter),
_spaceQ('space_062',QuestionDifficulty.medium400,'أي مركبة اكتشفت حلقات المشتري عام 1979؟','Which spacecraft discovered Jupiter’s rings in 1979?','فوياجر 1','Voyager 1',_jupiter),
_spaceQ('space_063',QuestionDifficulty.medium400,'أي قمر للمشتري يُعتقد أن تحته محيط من الماء السائل؟','Which Jupiter moon is believed to have a liquid-water ocean beneath its icy crust?','أوروبا','Europa',_jupiter),
_spaceQ('space_064',QuestionDifficulty.medium400,'كم يستغرق ضوء الشمس للوصول إلى المشتري تقريباً؟','About how long does sunlight take to reach Jupiter?','43 دقيقة','About 43 minutes',_jupiter),
_spaceQ('space_065',QuestionDifficulty.medium400,'ما متوسط بُعد المشتري عن الشمس بالوحدات الفلكية؟','What is Jupiter’s average distance from the Sun in astronomical units?','5.2 وحدة فلكية','5.2 AU',_jupiter),
_spaceQ('space_066',QuestionDifficulty.medium400,'أي كوكب أقل كثافة من الماء؟','Which planet has an average density lower than water?','زحل','Saturn',_saturn),
_spaceQ('space_067',QuestionDifficulty.medium400,'ما أكبر أقمار زحل؟','What is Saturn’s largest moon?','تيتان','Titan',_saturn),
_spaceQ('space_068',QuestionDifficulty.medium400,'ما الغاز الذي يمنح أورانوس لونه الأزرق المخضر؟','Which gas gives Uranus its blue-green color?','الميثان','Methane',_uranus),
_spaceQ('space_069',QuestionDifficulty.medium400,'ما الغاز الذي يساهم في اللون الأزرق لنبتون؟','Which gas contributes to Neptune’s blue appearance?','الميثان','Methane',_neptune),
_spaceQ('space_070',QuestionDifficulty.medium400,'ما أكبر أقمار نبتون؟','What is Neptune’s largest moon?','تريتون','Triton',_neptune),
_spaceQ('space_071',QuestionDifficulty.medium400,'ما الوحدة الفلكية AU؟','What does one astronomical unit (AU) represent?','متوسط المسافة بين الأرض والشمس','The average distance between Earth and the Sun',_planets),
_spaceQ('space_072',QuestionDifficulty.medium400,'ما اسم الطبقة المرئية من الشمس التي نراها عادةً؟','What is the visible surface layer of the Sun called?','الفوتوسفير','The photosphere',_sun),

// 600 — 30 questions
_spaceQ('space_073',QuestionDifficulty.hard600,'كم تبلغ إمالة محور عطارد تقريباً؟','About how much is Mercury’s rotational axis tilted?','نحو درجتين','About 2 degrees',_mercury),
_spaceQ('space_074',QuestionDifficulty.hard600,'كم يستغرق ضوء الشمس للوصول إلى عطارد تقريباً؟','About how long does sunlight take to reach Mercury?','3.2 دقائق','About 3.2 minutes',_mercury),
_spaceQ('space_075',QuestionDifficulty.hard600,'ما متوسط بُعد عطارد عن الشمس بالوحدات الفلكية؟','What is Mercury’s average distance from the Sun in AU?','0.4 وحدة فلكية','0.4 AU',_mercury),
_spaceQ('space_076',QuestionDifficulty.hard600,'كم تبلغ إمالة محور الزهرة تقريباً وفق وصف NASA لاتجاه دورانه؟','What is Venus’ effective axial tilt associated with its retrograde rotation?','نحو 177 درجة','About 177 degrees',_venus),
_spaceQ('space_077',QuestionDifficulty.hard600,'كم تستغرق دورة أطوار الزهرة من جديد إلى كامل تقريباً؟','About how long does the full cycle of Venus phases take?','584 يوماً','584 days',_venus),
_spaceQ('space_078',QuestionDifficulty.hard600,'أي مركبة تابعة لناسا رسمت سطح الزهرة بالرادار وانتهت مهمتها عام 1994؟','Which NASA spacecraft mapped Venus by radar and ended its mission in 1994?','ماجلان','Magellan',_venus),
_spaceQ('space_079',QuestionDifficulty.hard600,'كم تبلغ إمالة محور دوران المريخ تقريباً؟','About how much is Mars’ rotational axis tilted?','25 درجة','25 degrees',_mars),
_spaceQ('space_080',QuestionDifficulty.hard600,'كم يستغرق ضوء الشمس للوصول إلى المريخ تقريباً؟','About how long does sunlight take to reach Mars?','13 دقيقة','About 13 minutes',_mars),
_spaceQ('space_081',QuestionDifficulty.hard600,'كم يبلغ متوسط بُعد المريخ عن الشمس بالوحدات الفلكية؟','What is Mars’ average distance from the Sun in AU?','1.5 وحدة فلكية','1.5 AU',_mars),
_spaceQ('space_082',QuestionDifficulty.hard600,'ما اسم الفوهة الكبيرة البارزة على فوبوس؟','What is the prominent large crater on Phobos called?','ستيكني','Stickney',_marsMoons),
_spaceQ('space_083',QuestionDifficulty.hard600,'كم يبلغ قطر فوهة ستيكني على فوبوس تقريباً؟','About how wide is Stickney crater on Phobos?','10 كيلومترات تقريباً','About 10 kilometers',_marsMoons),
_spaceQ('space_084',QuestionDifficulty.hard600,'بأي معدل يقترب فوبوس من المريخ تقريباً كل مئة سنة؟','About how much closer to Mars does Phobos move every 100 years?','1.8 متر','About 1.8 meters',_marsMoons),
_spaceQ('space_085',QuestionDifficulty.hard600,'بعد نحو كم سنة يُتوقع أن يصطدم فوبوس بالمريخ أو يتفتت؟','In roughly how many years may Phobos crash into Mars or break apart?','نحو 50 مليون سنة','About 50 million years',_marsMoons),
_spaceQ('space_086',QuestionDifficulty.hard600,'كم يبلغ نصف قطر المشتري تقريباً؟','What is Jupiter’s radius approximately?','69,911 كيلومتراً','About 69,911 km',_jupiter),
_spaceQ('space_087',QuestionDifficulty.hard600,'كم مرة تقريباً يزيد عرض المشتري على عرض الأرض؟','About how many times wider is Jupiter than Earth?','11 مرة','About 11 times',_jupiter),
_spaceQ('space_088',QuestionDifficulty.hard600,'كم يوماً أرضياً تقريباً يستغرق مدار المشتري حول الشمس؟','About how many Earth days does Jupiter take to orbit the Sun?','4,333 يوماً','About 4,333 days',_jupiter),
_spaceQ('space_089',QuestionDifficulty.hard600,'كم تبلغ إمالة محور المشتري تقريباً؟','About how much is Jupiter’s axis tilted?','3 درجات','About 3 degrees',_jupiter),
_spaceQ('space_090',QuestionDifficulty.hard600,'أي قمر أكبر من كوكب عطارد؟','Which moon is larger than the planet Mercury?','غانيميد','Ganymede',_jupiter),
_spaceQ('space_091',QuestionDifficulty.hard600,'ما اسم المهمة التي أطلقتها ناسا في 14 أكتوبر 2024 لدراسة أوروبا؟','Which NASA mission launched on Oct. 14, 2024 to study Europa?','أوروبا كليبر','Europa Clipper',_jupiter),
_spaceQ('space_092',QuestionDifficulty.hard600,'إلى أي عمق تقريباً قد تمتد البقعة الحمراء العظيمة تحت قمم سحب المشتري وفق بيانات جونو؟','About how deep below Jupiter’s cloud tops may the Great Red Spot extend according to Juno gravity data?','نحو 500 كيلومتر','About 500 km',_jupiter),
_spaceQ('space_093',QuestionDifficulty.hard600,'في أي سنة اكتُشفت حلقات المشتري؟','In what year were Jupiter’s rings discovered?','1979','1979',_jupiter),
_spaceQ('space_094',QuestionDifficulty.hard600,'ما اسم أكبر أقمار بلوتو؟','What is Pluto’s largest moon called?','شارون','Charon',_pluto),
_spaceQ('space_095',QuestionDifficulty.hard600,'في أي منطقة من النظام الشمسي يقع بلوتو؟','In which region of the solar system is Pluto located?','حزام كايبر','The Kuiper Belt',_pluto),
_spaceQ('space_096',QuestionDifficulty.hard600,'ما أول كوكب قزم زارته مركبة فضائية؟','What was the first dwarf planet visited by a spacecraft?','سيريس','Ceres',_ceres),
_spaceQ('space_097',QuestionDifficulty.hard600,'ما اسم المركبة التي دخلت مدار سيريس عام 2015؟','Which spacecraft entered orbit around Ceres in 2015?','دون (Dawn)','Dawn',_ceres),
_spaceQ('space_098',QuestionDifficulty.hard600,'مما تتكون نواة المذنب أساساً؟','What is a comet nucleus primarily made of?','جليد وغبار ومواد صخرية','Ice, dust, and rocky material',_comets),
_spaceQ('space_099',QuestionDifficulty.hard600,'في أي اتجاه يشير ذيل المذنب عادةً بالنسبة للشمس؟','Which direction does a comet’s tail generally point relative to the Sun?','بعيداً عن الشمس','Away from the Sun',_comets),
_spaceQ('space_100',QuestionDifficulty.hard600,'ما العملية التي تنتج طاقة الشمس؟','What process powers the Sun?','الاندماج النووي','Nuclear fusion',_sun),
_spaceQ('space_101',QuestionDifficulty.hard600,'ما العنصر الذي تدمجه الشمس أساساً لإنتاج الهيليوم؟','Which element does the Sun primarily fuse to produce helium?','الهيدروجين','Hydrogen',_sun),
_spaceQ('space_102',QuestionDifficulty.hard600,'ما اسم الحد الفاصل الذي يُعد بداية الفضاء بين النجمي بعد تأثير الرياح الشمسية؟','What boundary marks the outer edge of the heliosphere before interstellar space?','الهيليوبوز','The heliopause',_sun),
];
