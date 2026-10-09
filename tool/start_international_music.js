const fs=require('fs');const dir='content/international_music';fs.mkdirSync(dir,{recursive:true});
for(const t of ['easy','medium','hard'])fs.writeFileSync(`${dir}/${t}.psv`,'id|factKey|source|questionAr|questionEn|answerAr|answerEn\n');fs.writeFileSync(`${dir}/sources.psv`,'key|name|url|evidence\n');
const source=(key,name,url,evidence)=>fs.appendFileSync(`${dir}/sources.psv`,[key,name,url,'Retrieved or indexed 2026-10-08: '+evidence].join('|')+'\n');
source('queen','Queen official — A Night At The Opera anniversary','https://www.queenonline.com/news/out-today-bohemian-rhapsody-50th-anniversary-vinyl-reissues','Queen, Bohemian Rhapsody, A Night At The Opera and producer Roy Thomas Baker.');
source('abba','ABBA official — Dancing Queen history','https://abbasite.com/articles/dancing-queen/','ABBA song on Arrival; original working title Boogaloo. No lyrics reproduced.');
source('mj','Library of Congress — Thriller credits','https://www.loc.gov/item/86708393/','Michael Jackson performs Thriller; title-song writer Rod Temperton; title-song producers Quincy Jones and Michael Jackson.');
source('mjprod','Library of Congress — National Recording Registry','https://www.loc.gov/item/prn-08-079/','Thriller album produced by Quincy Jones.');
source('beatles','Beatles official — Come Together','https://www.thebeatles.com/come-together','The Beatles; opening track Abbey Road; producer George Martin; recorded EMI Studios London. Historical author John Lennon distinct from Lennon-McCartney legal credit, not questioned.');
source('adele','Adele official — 21 tracklist','https://shop.adele.com/products/21-lp','Rolling In The Deep included on 21.');
source('adelecredits','Recording Academy — Adele and Rolling In The Deep','https://www.grammy.com/news/and-the-grammy-went-to-adele/','Adele performs Rolling In The Deep; co-written with producer Paul Epworth.');
source('ed','Ed Sheeran official — Divide','https://www.edsheeran.com/music/571','Ed Sheeran, Shape Of You track on Divide.');
source('edcredit','Apple Music label-supplied credits — Shape Of You','https://music.apple.com/us/song/1847684947','Steve Mac producer; Ed Sheeran co-producer. Specific producer role asked, not sole authorship.');
source('whitney','Whitney Houston official — I Will Always Love You','https://www.whitneyhouston.com/track/i-will-always-love-you/','Whitney performs Bodyguard recording; songwriter Dolly Parton; producer David Foster.');
source('celine','Celine Dion official biography','https://www.celinedion.com/about/biography/','Celine Dion performs My Heart Will Go On, theme of Titanic.');
source('titanic','Academy Awards official 1998 song credit','https://www.oscars.org/oscars/ceremonies/1998','My Heart Will Go On in Titanic; music James Horner; lyric Will Jennings.');
source('coldplay','Coldplay official — A Rush Of Blood To The Head','https://www.coldplay.com/release/a-rush-of-blood-to-the-head/','Clocks album track, artist Coldplay.');
source('clocksprod','Recording Academy — Record Of The Year 2004','https://www.grammy.com/awards/categories/record-of-the-year/2004/','Clocks by Coldplay; producers Coldplay and Ken Nelson.');
source('u2','U2 official — The Joshua Tree','https://www.u2.com/products/u2-the-joshua-tree','With Or Without You track; produced/engineered by Daniel Lanois and Brian Eno.');
source('elton','Elton John official — Elton John album','https://www.eltonjohn.com/discography/elton-john-2','Your Song; Elton John/Bernie Taupin music and lyrics; orchestral arrangements Paul Buckmaster.');
source('eltontaupin','Elton John official — Your Song recording history','https://www.eltonjohn.com/stories/your-song-named-the-uks-favourite-elton-song','Elton set Bernie Taupin words to music; recorded Trident Studios.');
source('bowie','David Bowie official — Heroes album','https://www.davidbowie.com/heroes','David Bowie performs Heroes; RCA label; co-producers David Bowie and Tony Visconti.');
const rows={easy:[],medium:[],hard:[]};
function q(t,id,key,s,ar,en,aa,ae){rows[t].push([String(id).padStart(3,'0'),key,s,ar,en,aa,ae].join('|'));}
const easy=[
['bohemian','queen','أي فرقة قدّمت «بوهيميان رابسودي»؟','Which band performs Bohemian Rhapsody?','كوين','Queen'],
['dancingqueen','abba','أي فرقة سويدية غنّت «دانسينغ كوين»؟','Which Swedish group sings Dancing Queen?','آبا','ABBA'],
['thriller','mj','من المطرب صاحب أغنية «ثريلر» وكليبها الشهير؟','Which singer performs Thriller and stars in its famous video?','مايكل جاكسون','Michael Jackson'],
['cometogether','beatles','أي فرقة غنّت «كَم توغيذر» في تسجيلها الأصلي؟','Which band made the original recording of Come Together?','البيتلز','The Beatles'],
['rollingdeep','adelecredits','من المطربة صاحبة أغنية «رولينغ إن ذا ديب»؟','Which singer performs Rolling In The Deep?','أديل','Adele'],
['shapeofyou','ed','من غنّى «شيب أوف يو»؟','Who sings Shape Of You?','إد شيران','Ed Sheeran'],
['iwillalways','whitney','من المطربة التي غنّت «آي ويل أولويز لوف يو» في فيلم «ذا بوديغارد»؟','Which singer performs I Will Always Love You in The Bodyguard?','ويتني هيوستن','Whitney Houston'],
['myheart','celine','من المطربة التي غنّت «ماي هارت ويل غو أون»؟','Which singer performs My Heart Will Go On?','سيلين ديون','Celine Dion'],
['clocks','coldplay','أي فرقة بريطانية أصدرت أغنية «كلوكس»؟','Which British band released Clocks?','كولدبلاي','Coldplay'],
['withwithout','u2','أي فرقة أيرلندية غنّت «ويذ أور ويذاوت يو»؟','Which Irish band sings With Or Without You?','يو تو','U2'],
['yoursong','elton','من المطرب صاحب التسجيل الأصلي لأغنية «يور سونغ»؟','Which singer made the original recording of Your Song?','إلتون جون','Elton John'],
['heroes','bowie','من المطرب صاحب أغنية «هيروز» الصادرة عام 1977؟','Which singer released Heroes in 1977?','ديفيد بوي','David Bowie']];
easy.forEach(([k,s,...r],i)=>q('easy',i+1,`song:${k}:performer`,s,...r));
const medium=[
['bohemian','queen','في أي ألبوم لكوين صدرت «بوهيميان رابسودي»؟','On which Queen album was Bohemian Rhapsody released?','أ نايت آت ذي أوبرا','A Night At The Opera'],
['dancingqueen','abba','في أي ألبوم لآبا صدرت «دانسينغ كوين»؟','On which ABBA album was Dancing Queen released?','أرايفال','Arrival'],
['thrillerproducer','mjprod','من أنتج ألبوم مايكل جاكسون «ثريلر»؟','Who produced Michael Jackson\'s Thriller album?','كوينسي جونز','Quincy Jones'],
['cometogether','beatles','أي ألبوم للبيتلز يبدأ بأغنية «كَم توغيذر»؟','Which Beatles album opens with Come Together?','آبي رود','Abbey Road'],
['rollingdeep','adele','في أي ألبوم لأديل صدرت «رولينغ إن ذا ديب»؟','On which Adele album was Rolling In The Deep released?','21','21'],
['shapeofyou','ed','في أي ألبوم لإد شيران صدرت «شيب أوف يو»؟','On which Ed Sheeran album was Shape Of You released?','ديفايد (÷)','Divide (÷)'],
['iwillalwayswriter','whitney','من كتبت أغنية «آي ويل أولويز لوف يو» قبل أن تغنّيها ويتني هيوستن؟','Who wrote I Will Always Love You before Whitney Houston recorded it?','دولي بارتون','Dolly Parton'],
['myheartfilm','celine','لأي فيلم كانت «ماي هارت ويل غو أون» أغنية الختام الشهيرة؟','For which film is My Heart Will Go On the famous closing theme?','تايتانيك','Titanic'],
['clocks','coldplay','في أي ألبوم لكولدبلاي صدرت «كلوكس»؟','On which Coldplay album was Clocks released?','أ رش أوف بلَد تو ذا هيد','A Rush Of Blood To The Head'],
['withwithout','u2','في أي ألبوم ليو تو صدرت «ويذ أور ويذاوت يو»؟','On which U2 album was With Or Without You released?','ذا جوشوا تري','The Joshua Tree'],
['yoursongwriter','eltontaupin','من كتب كلمات «يور سونغ» التي لحّنها إلتون جون؟','Who wrote the lyrics of Your Song, composed by Elton John?','بيرني توبين','Bernie Taupin'],
['heroeslabel','bowie','تحت اسم أي شركة تسجيل صدر ألبوم ديفيد بوي «هيروز» عام 1977؟','Which record label originally released David Bowie\'s Heroes in 1977?','آر سي إيه','RCA']];
medium.forEach(([k,s,...r],i)=>q('medium',69+i,`music:${k}:attribute`,s,...r));
const hard=[
['bohemianproducer','queen','أي منتج شارك كوين تسجيل «أ نايت آت ذي أوبرا»، الألبوم الذي يضم «بوهيميان رابسودي»؟','Which producer worked with Queen on A Night At The Opera, the album containing Bohemian Rhapsody?','روي توماس بيكر','Roy Thomas Baker'],
['dancingqueenworking','abba','ما العنوان المؤقت لأغنية آبا «دانسينغ كوين» خلال مراحلها الأولى؟','What was the early working title of ABBA\'s Dancing Queen?','بوغالو','Boogaloo'],
['thrillerwriter','mj','من كتب أغنية «ثريلر» لمايكل جاكسون؟','Who wrote Michael Jackson\'s Thriller?','رود تمبرتون','Rod Temperton'],
['cometogetherstudio','beatles','في أي استوديو بلندن سجّل البيتلز «كَم توغيذر» في يوليو 1969؟','At which London studio did the Beatles record Come Together in July 1969?','استوديوهات إي إم آي','EMI Studios'],
['rollingdeepcowriter','adelecredits','من المنتج الذي شارك أديل كتابة «رولينغ إن ذا ديب»؟','Which producer co-wrote Rolling In The Deep with Adele?','بول إبوورث','Paul Epworth'],
['shapeofyouproducer','edcredit','من المنتج الذي شارك إد شيران إنتاج تسجيل «شيب أوف يو»؟','Which producer worked alongside Ed Sheeran on the recording of Shape Of You?','ستيف ماك','Steve Mac'],
['iwillalwaysproducer','whitney','من أنتج تسجيل ويتني هيوستن لأغنية «آي ويل أولويز لوف يو»؟','Who produced Whitney Houston\'s recording of I Will Always Love You?','ديفيد فوستر','David Foster'],
['myheartwriter','titanic','من كتب كلمات «ماي هارت ويل غو أون» على موسيقى جيمس هورنر؟','Who wrote the lyrics of My Heart Will Go On to James Horner\'s music?','ويل جينينغز','Will Jennings'],
['clocksproducer','clocksprod','من المنتج الذي شارك كولدبلاي إنتاج «كلوكس»، بحسب رصيد غرامي لعام 2004؟','Which producer worked with Coldplay on Clocks, according to its 2004 Grammy credits?','كين نيلسون','Ken Nelson'],
['joshuaproducers','u2','من الثنائي الذي أنتج ألبوم يو تو «ذا جوشوا تري»؟','Which duo produced U2\'s The Joshua Tree?','دانيال لانوا وبرايان إينو','Daniel Lanois and Brian Eno'],
['eltonorchestral','elton','من كتب التوزيعات الأوركسترالية لألبوم «إلتون جون» الذي يبدأ بـ«يور سونغ»؟','Who wrote the orchestral arrangements for the Elton John album that opens with Your Song?','بول باكماستر','Paul Buckmaster'],
['heroesproducer','bowie','من شارك ديفيد بوي إنتاج ألبوم «هيروز»؟','Who co-produced Heroes alongside David Bowie?','توني فيسكونتي','Tony Visconti']];
hard.forEach(([k,s,...r],i)=>q('hard',137+i,`music:${k}:attribute`,s,...r));
for(const [t,rs]of Object.entries(rows))fs.appendFileSync(`${dir}/${t}.psv`,rs.join('\n')+'\n');
console.log('International Music: 36 researched bilingual drafts saved.');
