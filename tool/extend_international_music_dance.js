const fs=require('fs'),d='content/international_music';
const sources=[
['eminemoscars','Academy — 2003 Original Song credits','https://www.oscars.org/oscars/ceremonies/2003/0--9','Lose Yourself from 8 Mile; music Eminem, Jeff Bass and Luis Resto; lyrics Eminem.'],
['uptowncredits','Recording Academy — 2016 Record of the Year','https://www.grammy.com/awards/categories/record-of-the-year/2016/','Uptown Funk, Mark Ronson featuring Bruno Mars; mastering engineer Tom Coyne.'],
['uptownalbum','Recording Academy — Mark Ronson','https://www.grammy.com/artists/mark-ronson/17323/','Uptown Special contains Uptown Funk.'],
['happyfilm','Academy — Pharrell performance announcement','https://www.oscars.org/news/pharrell-williams-perform-oscarsr','Pharrell Williams performs Happy; wrote and produced it for Despicable Me 2.'],
['happyvideo','VideoStatic — Happy Grammy-winning directors','https://www.videostatic.com/news/2015/02/08/pharrell-and-directors-we-are-la-win-best-music-video-grammy','Specialist music-video trade source identifies We Are From L.A. as Happy directors; corroborated by Recording Academy award profile.'],
['daftlucky','Recording Academy — Get Lucky award retrospective','https://www.grammy.com/news/daft-punk-get-lucky-grammy-win-pharrell-williams-acceptance-speech-video-rewind/','Daft Punk; Thomas Bangalter and Guy-Manuel de Homem-Christo; Get Lucky.'],
['daftram','Recording Academy — Random Access Memories','https://www.grammy.com/news/daft-punk-random-access-memories-record/','Random Access Memories includes Get Lucky.'],
['aviciitrue','Apple Music — True editorial','https://music.apple.com/us/album/true/677375839?i=677376024','Avicii Wake Me Up; vocalist Aloe Blacc; co-writer Mike Einziger of Incubus.'],
['titaniumcredits','David Guetta official video — licensed recording credits','https://www.youtube.com/watch?v=gRw_6NTbPSo','Original 2011 Titanium metadata in 2025 live-video description: David Guetta featuring Sia; guitar Pierre-Luc Rioux.'],
['calvinmotion','Sony Music Italy — Outside release','https://www.sonymusic.it/news/da-oggi-radio-outside-il-nuovo-singolo-di-calvin-harris-feat-ellie-goulding-estratto-dallalbum/','Calvin Harris Motion includes Summer; Outside video directed by Emil Nava.'],
['marleynatty','Bob Marley official — Natty Dread','https://www.bobmarley.com/release/natty-dread-1974/','No Woman No Cry on Natty Dread; I-Threes members Rita Marley, Marcia Griffiths and Judy Mowatt.']
];for(const [k,n,u,e]of sources)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const data={easy:`037|song:loseyourself:performer|eminemoscars|أي رابر اشتهر بأغنية «لوز يورسِلف» من فيلم «8 مايل»؟|Which rapper is known for Lose Yourself from 8 Mile?|إيمينيم|Eminem
038|song:uptownfunk:guestvocalist|uptowncredits|من المطرب الذي شارك مارك رونسون في «أبتاون فانك»؟|Which singer features on Mark Ronson's Uptown Funk?|برونو مارس|Bruno Mars
039|song:happy:performer|happyfilm|من المطرب صاحب أغنية «هابي»؟|Which singer performs Happy?|فاريل ويليامز|Pharrell Williams
040|song:getlucky:performer|daftlucky|أي ثنائي إلكتروني أصدر «غِت لاكي»؟|Which electronic duo released Get Lucky?|دافت بانك|Daft Punk
041|song:wakemeup:artist|aviciitrue|أي دي جي سويدي أصدر «ويك مي أب»؟|Which Swedish DJ released Wake Me Up?|أفيتشي|Avicii
042|song:titanium:artist|titaniumcredits|من الدي جي صاحب أغنية «تيتانيوم» بمشاركة سيا؟|Which DJ released Titanium featuring Sia?|ديفيد غيتا|David Guetta
043|song:summer:artist|calvinmotion|أي دي جي أصدر أغنية «سامر» عام 2014؟|Which DJ released Summer in 2014?|كالفن هاريس|Calvin Harris
044|song:nowomannocry:singer|marleynatty|أي مطرب جامايكي اشتهر بأغنية «نو وومان نو كراي»؟|Which Jamaican singer is known for No Woman No Cry?|بوب مارلي|Bob Marley`,
medium:`105|song:loseyourself:film|eminemoscars|لأي فيلم كُتبت أغنية إيمينيم «لوز يورسِلف»؟|For which film was Eminem's Lose Yourself written?|8 مايل|8 Mile
106|song:uptownfunk:album|uptownalbum|ما ألبوم مارك رونسون الذي يضم «أبتاون فانك»؟|Which Mark Ronson album contains Uptown Funk?|أبتاون سبيشال|Uptown Special
107|song:happy:film|happyfilm|في أي فيلم رسوم متحركة ظهرت أغنية فاريل ويليامز «هابي»؟|In which animated film did Pharrell Williams' Happy appear?|ديسبيكابل مي 2|Despicable Me 2
108|song:getlucky:album|daftram|ما ألبوم دافت بانك الذي يضم «غِت لاكي»؟|Which Daft Punk album contains Get Lucky?|راندوم أكسِس ميموريز|Random Access Memories
109|song:wakemeup:vocalist|aviciitrue|من أدّى الغناء في أغنية أفيتشي «ويك مي أب»؟|Who provides the vocals on Avicii's Wake Me Up?|ألو بلاك|Aloe Blacc
110|song:titanium:guestvocalist|titaniumcredits|من المطربة التي شاركت ديفيد غيتا في «تيتانيوم»؟|Which singer features on David Guetta's Titanium?|سيا|Sia
111|song:summer:album|calvinmotion|ما ألبوم كالفن هاريس الذي يضم «سامر»؟|Which Calvin Harris album contains Summer?|موشن|Motion
112|song:nowomannocry:firststudioalbum|marleynatty|في أي ألبوم استوديو صدرت «نو وومان نو كراي» أول مرة؟|On which studio album was No Woman No Cry first released?|ناتي دريد|Natty Dread`,
hard:`173|song:loseyourself:othercomposers|eminemoscars|من شاركا إيمينيم تأليف موسيقى «لوز يورسِلف»، وفق اعتماد الأوسكار؟|Who co-composed the music for Lose Yourself with Eminem, according to its Oscar credit?|جيف باس ولويس ريستو|Jeff Bass and Luis Resto
174|song:uptownfunk:mastering|uptowncredits|من مهندس الماسترينغ المعتمد لتسجيل «أبتاون فانك» الفائز بغرامي؟|Who is the credited mastering engineer for the Grammy-winning Uptown Funk recording?|توم كوين|Tom Coyne
175|song:happy:videodirectors|happyvideo|ما اسم الثنائي الذي أخرج كليب «هابي» لفاريل ويليامز، الفائز بغرامي 2015؟|What is the name of the duo that directed Pharrell Williams' Happy video, winner of a 2015 Grammy?|وي آر فروم إل إيه|We Are From L.A.
176|artist:daftpunk:members|daftlucky|من العضوان اللذان شكّلا ثنائي دافت بانك؟|Which two musicians formed Daft Punk?|توماس بانغالتر وغي مانويل دو أوميم كريستو|Thomas Bangalter and Guy-Manuel de Homem-Christo
177|song:wakemeup:incubuscowriter|aviciitrue|أي عضو من فرقة إنكيوبيس شارك كتابة «ويك مي أب» لأفيتشي؟|Which Incubus member co-wrote Avicii's Wake Me Up?|مايك آينزيغر|Mike Einziger
178|song:titanium:guitarist|titaniumcredits|من عازف الغيتار المعتمد في تسجيل «تيتانيوم» الأصلي لديفيد غيتا وسيا؟|Who is the credited guitarist on David Guetta and Sia's original Titanium recording?|بيير لوك ريو|Pierre-Luc Rioux
179|song:outside:videodirector|calvinmotion|من أخرج كليب «أوتسايد» لكالفن هاريس وإيلي غولدنغ؟|Who directed Calvin Harris and Ellie Goulding's Outside video?|إميل نافا|Emil Nava
180|album:nattydread:ithreesmembers|marleynatty|من المغنيات الثلاث في فرقة آي ثريز التي شاركت في ألبوم بوب مارلي «ناتي دريد»؟|Which three singers formed the I-Threes who appeared on Bob Marley's Natty Dread?|ريتا مارلي ومارسيا غريفيثس وجودي موات|Rita Marley, Marcia Griffiths and Judy Mowatt`};
for(const [level,rows]of Object.entries(data))fs.appendFileSync(`${d}/${level}.psv`,rows+'\n');
