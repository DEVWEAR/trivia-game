const fs=require('fs'),d='content/international_music';
const sources=[
['swift','Recording Academy — 1989 retrospective','https://live.grammy.com/news/taylor-swift-1989-taylors-version-pop-stardom','Shake It Off heralded 1989; Max Martin and Shellback worked with Swift. Original 2014 recording specified for author credit.'],
['swiftwriters','Recording Academy — Shellback credits','https://www.grammy.com/artists/shellback/6459/','2015 Song Of The Year nomination Shake It Off lists Max Martin, Shellback and Taylor Swift.'],
['helloalbum','Adele official — 25 tracklist','https://shop.adele.com/products/25-lp','Hello included on 25.'],
['helloprod','Recording Academy — Record Of The Year 2017','https://www.grammy.com/awards/categories/record-of-the-year/2017/','Hello performed by Adele; producer Greg Kurstin.'],
['gaga','Recording Academy — Fame Monster retrospective','https://www.grammy.com/news/lady-gaga-the-fame-monster-best-pop-vocal-album-2011-grammys-acceptance-speech-video-rewind-whitney-houston-born-this-way/','Lady Gaga; Bad Romance from The Fame Monster; no erroneous 2010 original release claim used.'],
['gagaprod','Recording Academy — Best Pop Vocal Album 2011','https://www.grammy.com/awards/categories/best-pop-vocal-album/2011/','The Fame Monster lists Lady Gaga and RedOne as producers.'],
['halo','Recording Academy — 2010 ceremony and credits','https://www.grammy.com/awards/52nd-annual-grammy-awards/','Halo by Beyonce wins Best Female Pop Vocal Performance; Beyonce and Ryan Tedder producers.'],
['umbrella','Recording Academy — Rihanna first Grammy','https://www.grammy.com/news/rihanna-jay-z-umbrella-best-rap-sung-collaboration-grammy-rewind/','Rihanna and Jay-Z Umbrella from Good Girl Gone Bad; 2008 Grammy performance with The Time. No conflation of songwriter and producer roles.'],
['dua','Recording Academy — Future Nostalgia production interview','https://www.grammy.com/news/dua-lipa-2021-grammys-future-nostalgia/','Dua Lipa; Levitating included on Future Nostalgia; Chris Gehringer explicitly interviewed as album mastering engineer.'],
['sia','Recording Academy — Sia artist credits','https://www.grammy.com/artists/sia/15372/','Sia performs Chandelier on 1000 Forms Of Fear; Song Of The Year 2015 nominees Sia and Jesse Shatkin.'],
['billie','Recording Academy — bad guy Song Of The Year 2020','https://www.grammy.com/news/billie-eilish-finneas-wins-song-year-bad-guy-2020-grammys/','Billie Eilish sings bad guy on debut When We All Fall Asleep Where Do We Go.'],
['billieengineering','Recording Academy — 2020 complete credited nominations and winners','https://www.grammy.com/news/2020-grammy-awards-nominations-complete-winners-list/','bad guy: producer Finneas OConnell; engineers Rob Kinelski and Finneas; mastering engineer John Greenham.']
];for(const [k,n,u,e]of sources)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const data={easy:`021|song:shakeitoff:performer|swift|من غنّت «شيك إت أوف» في تسجيلها الأصلي عام 2014؟|Who sings the original 2014 recording of Shake It Off?|تايلور سويفت|Taylor Swift
022|song:hello:performer|helloprod|من المطربة صاحبة أغنية «هيلو» الصادرة عام 2015؟|Which singer released Hello in 2015?|أديل|Adele
023|song:badromance:performer|gaga|من المطربة صاحبة أغنية «باد رومانس»؟|Which singer performs Bad Romance?|ليدي غاغا|Lady Gaga
024|song:halo:performer|halo|من المطربة صاحبة أغنية «هالو» التي فازت بغرامي عام 2010؟|Which singer performs Halo, the 2010 Grammy winner?|بيونسيه|Beyonce
025|song:umbrella:performer|umbrella|من المطربة صاحبة أغنية «أمبريلا»؟|Which singer performs Umbrella?|ريهانا|Rihanna
026|song:levitating:performer|dua|من المطربة صاحبة أغنية «ليفيتيتينغ»؟|Which singer performs Levitating?|دوا ليبا|Dua Lipa
027|song:chandelier:performer|sia|من المطربة الأسترالية صاحبة أغنية «شانديليير»؟|Which Australian singer performs Chandelier?|سيا|Sia
028|song:badguy:performer|billie|من المطربة صاحبة أغنية «باد غاي»؟|Which singer performs bad guy?|بيلي إيليش|Billie Eilish`,
medium:`089|song:shakeitoff:album|swift|في أي ألبوم لتايلور سويفت صدرت النسخة الأصلية من «شيك إت أوف»؟|On which Taylor Swift album was the original Shake It Off released?|1989|1989
090|song:hello:album|helloalbum|في أي ألبوم لأديل صدرت «هيلو»؟|On which Adele album was Hello released?|25|25
091|song:badromance:album|gaga|أي إصدار لليدي غاغا يضم أغنية «باد رومانس»؟|Which Lady Gaga release includes Bad Romance?|ذا فيم مونستر|The Fame Monster
092|award:halo:2010category|halo|بأي فئة غرامي فازت بيونسيه بأغنية «هالو» عام 2010؟|In which Grammy category did Beyonce win for Halo in 2010?|أفضل أداء صوتي بوب نسائي|Best Female Pop Vocal Performance
093|song:umbrella:album|umbrella|في أي ألبوم لريهانا صدرت «أمبريلا»؟|On which Rihanna album was Umbrella released?|غود غيرل غون باد|Good Girl Gone Bad
094|song:levitating:album|dua|في أي ألبوم لدوا ليبا صدرت «ليفيتيتينغ»؟|On which Dua Lipa album was Levitating released?|فيوتشر نوستالجيا|Future Nostalgia
095|song:chandelier:album|sia|في أي ألبوم لسيا صدرت «شانديليير»؟|On which Sia album was Chandelier released?|1000 فورمز أوف فير|1000 Forms Of Fear
096|song:badguy:album|billie|ما ألبوم بيلي إيليش الأول الذي يضم «باد غاي»؟|What is Billie Eilish's debut album containing bad guy called?|وِن وي أول فول أسليب، وير دو وي غو؟|When We All Fall Asleep, Where Do We Go?`,
hard:`157|song:shakeitoff:cowriters|swiftwriters|من شاركا تايلور سويفت كتابة النسخة الأصلية من «شيك إت أوف»؟|Who were Taylor Swift's two co-writers on the original Shake It Off?|ماكس مارتن وشيلباك|Max Martin and Shellback
158|song:hello:producer|helloprod|من أنتج تسجيل أديل لأغنية «هيلو»؟|Who produced Adele's Hello?|غريغ كيرستين|Greg Kurstin
159|album:famemonster:coproducer|gagaprod|من شارك ليدي غاغا إنتاج «ذا فيم مونستر»، بحسب رصيد غرامي عام 2011؟|Who co-produced The Fame Monster with Lady Gaga, according to its 2011 Grammy credits?|ريد ون|RedOne
160|song:halo:coproducer|halo|من شارك بيونسيه إنتاج «هالو»؟|Who co-produced Halo alongside Beyonce?|رايان تيدر|Ryan Tedder
161|performance:umbrella:grammy2008band|umbrella|أي فرقة شاركت ريهانا أداء «أمبريلا» في حفل غرامي عام 2008؟|Which band performed Umbrella with Rihanna at the 2008 Grammy ceremony?|ذا تايم|The Time
162|album:futurenostalgia:mastering|dua|من تولّى الماسترينغ لألبوم دوا ليبا «فيوتشر نوستالجيا»؟|Who mastered Dua Lipa's Future Nostalgia?|كريس غيرينغر|Chris Gehringer
163|song:chandelier:cowriter|sia|من شارك سيا كتابة أغنية «شانديليير»؟|Who co-wrote Chandelier with Sia?|جيسي شاتكين|Jesse Shatkin
164|song:badguy:mastering|billieengineering|من مهندس الماسترينغ لتسجيل «باد غاي»، بحسب رصيد غرامي عام 2020؟|Who mastered bad guy, according to its 2020 Grammy credits?|جون غرينهام|John Greenham`};for(const [t,s]of Object.entries(data))fs.appendFileSync(`${d}/${t}.psv`,s+'\n');console.log('Added 24; total 84 drafts.');
