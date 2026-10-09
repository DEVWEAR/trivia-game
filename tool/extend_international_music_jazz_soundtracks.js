const fs=require('fs'),d='content/international_music';
const sources=[
['armstrong','Songwriters Hall of Fame — What A Wonderful World','https://www.songhall.org/profiles/what-a-wonderful-world','Louis Armstrong recorded 1967 for ABC Records; words and music George David Weiss and Bob Thiele.'],
['sinatra','Paul Anka official — My Way writing account','https://www.paulanka.com/news/behind-the-song-my-way-by-paul-anka','Sinatra My Way; Paul Anka English words; based on Comme dhabitude.'],
['elvis','Elvis Presley official — Cant Help Falling in Love','https://www.elvisthemusic.com/track/cant-help-falling-in-love/','Elvis Presley; recorded for Blue Hawaii; writers Hugo Peretti, Luigi Creatore, George Weiss.'],
['prince','Prince Estate — Purple Rain','https://discography.prince.com/albums/purple-rain','Prince and Revolution; several album songs captured live at First Avenue in Minneapolis.'],
['miles','Miles Davis official — Kind of Blue','https://www.milesdavis.com/albums/kind-of-blue-legacy-edition/','Kind of Blue includes So What; personnel identifies Jimmy Cobb on drums.'],
['brubeck','Dave Brubeck official — Time Out publication','https://www.davebrubeck.com/time-out-piano-book','Dave Brubeck Quartet Time Out; Take Five composed by saxophonist Paul Desmond.'],
['frozen','Disney official — Let It Go sequence','https://video.disney.com/watch/disney-s-frozen-let-it-go-sequence-performed-by-idina-menzel-4ecd3e729706a16e5090f1de','Frozen original film performance Idina Menzel; song by Kristen Anderson-Lopez and Robert Lopez.'],
['havenothing','Academy — 1993 Original Song credits','https://www.oscars.org/oscars/ceremonies/1993/S','I Have Nothing from The Bodyguard: music David Foster; lyric Linda Thompson.'],
['havenothingperformer','Recording Academy — Linda Thompson work credits','https://www.grammy.com/artists/linda-thompson/6715','I Have Nothing from The Bodyguard, Foster and Thompson songwriting credits.']
];for(const [k,n,u,e]of sources)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const rows={easy:[
['song:wonderfulworld:performer','armstrong','من المغنّي الذي سجّل «وات أ ووندرفُل وورلد» الشهيرة عام 1967؟','Who recorded the famous What a Wonderful World in 1967?','لويس أرمسترونغ','Louis Armstrong'],
['song:myway:sinatraversion','sinatra','أي مغنٍّ ارتبط اسمه بأغنية «ماي واي» التي كتب كلماتها الإنجليزية بول أنكا؟','Which singer is associated with My Way, with English lyrics by Paul Anka?','فرانك سيناترا','Frank Sinatra'],
['song:canthelpfalling:performer','elvis','من غنّى «كانت هِلب فولينغ إن لاف» في فيلم «بلو هاواي»؟',"Who sang Can't Help Falling in Love in Blue Hawaii?",'إلفيس بريسلي','Elvis Presley'],
['album:purplerain:artist','prince','من الفنان صاحب ألبوم «بيربل رين»؟','Which artist released Purple Rain?','برنس','Prince'],
['album:kindofblue:artist','miles','أي عازف ترومبيت جاز أصدر ألبوم «كايند أوف بلو»؟','Which jazz trumpeter released Kind of Blue?','مايلز ديفيس','Miles Davis'],
['song:takefive:performingquartet','brubeck','أي رباعي جاز اشتهر بتسجيل «تيك فايف»؟','Which jazz quartet is known for Take Five?','رباعي ديف بروبيك','The Dave Brubeck Quartet'],
['song:letitgo:originalsinger','frozen','من غنّت «لِت إت غو» بصوت إلسا في النسخة الإنجليزية من «فروزن»؟','Who sang Let It Go as Elsa in the original English Frozen?','إيدينا مينزل','Idina Menzel'],
['song:ihavenothing:performer','havenothingperformer','من المطربة صاحبة «آي هاف ناثينغ» من فيلم «ذا بوديغارد»؟','Which singer performs I Have Nothing from The Bodyguard?','ويتني هيوستن','Whitney Houston']],
medium:[
['song:wonderfulworld:recordingyear','armstrong','في أي سنة سجّل لويس أرمسترونغ النسخة الأصلية من «وات أ ووندرفُل وورلد»؟','In which year did Louis Armstrong record the original What a Wonderful World?','1967','1967'],
['song:myway:englishlyricist','sinatra','من كتب الكلمات الإنجليزية لأغنية سيناترا «ماي واي»؟',"Who wrote the English lyrics for Sinatra's My Way?",'بول أنكا','Paul Anka'],
['song:canthelpfalling:film','elvis','لأي فيلم سجّل إلفيس «كانت هِلب فولينغ إن لاف»؟',"For which film did Elvis record Can't Help Falling in Love?",'بلو هاواي','Blue Hawaii'],
['album:purplerain:band','prince','ما اسم الفرقة التي شاركت برنس ألبوم «بيربل رين»؟','What is the band that recorded Purple Rain with Prince called?','ذا ريفولوشن','The Revolution'],
['song:sowhat:album','miles','ما ألبوم مايلز ديفيس الذي يضم «سو وات»؟','Which Miles Davis album contains So What?','كايند أوف بلو','Kind of Blue'],
['song:takefive:album','brubeck','ما ألبوم رباعي ديف بروبيك الذي يضم «تيك فايف»؟','Which Dave Brubeck Quartet album contains Take Five?','تايم آوت','Time Out'],
['song:letitgo:film','frozen','في أي فيلم ديزني ظهرت «لِت إت غو» أول مرة؟','In which Disney film did Let It Go first appear?','فروزن','Frozen'],
['song:ihavenothing:film','havenothing','من أي فيلم جاءت أغنية ويتني هيوستن «آي هاف ناثينغ»؟',"Which film features Whitney Houston's I Have Nothing?",'ذا بوديغارد','The Bodyguard']],
hard:[
['song:wonderfulworld:writers','armstrong','من كتب كلمات وموسيقى «وات أ ووندرفُل وورلد»؟','Who wrote the words and music for What a Wonderful World?','جورج ديفيد وايس وبوب ثيلي','George David Weiss and Bob Thiele'],
['song:myway:frenchoriginal','sinatra','ما اسم الأغنية الفرنسية التي اقتُبست موسيقاها في «ماي واي»؟','What French song supplied the melody for My Way?','كوم دابيتود','Comme d\'habitude'],
['song:canthelpfalling:writers','elvis','من الكتّاب الثلاثة لأغنية إلفيس «كانت هِلب فولينغ إن لاف»؟',"Who are the three writers of Elvis' Can't Help Falling in Love?",'هوغو بيريتي ولويجي كرياتوري وجورج وايس','Hugo Peretti, Luigi Creatore and George Weiss'],
['album:purplerain:liverecordingvenue','prince','في أي نادٍ بمينيابوليس سُجّلت عدة أغنيات من ألبوم «بيربل رين» مباشرة أمام الجمهور؟','At which Minneapolis club were several Purple Rain album tracks recorded live?','فيرست أفنيو','First Avenue'],
['album:kindofblue:drummer','miles','من عازف الدرامز في ألبوم مايلز ديفيس «كايند أوف بلو»؟',"Who plays drums on Miles Davis' Kind of Blue?",'جيمي كوب','Jimmy Cobb'],
['song:takefive:composer','brubeck','من عازف الساكسفون الذي ألّف «تيك فايف»؟','Which saxophonist composed Take Five?','بول ديزموند','Paul Desmond'],
['song:letitgo:writers','frozen','من كتب «لِت إت غو» لفيلم «فروزن»؟','Who wrote Let It Go for Frozen?','كريستن أندرسون لوبيز وروبرت لوبيز','Kristen Anderson-Lopez and Robert Lopez'],
['song:ihavenothing:lyricist','havenothing','من كتبت كلمات «آي هاف ناثينغ»، التي لحّنها ديفيد فوستر؟','Who wrote the lyrics for I Have Nothing, with music by David Foster?','ليندا تومبسون','Linda Thompson']]};
for(const [level,items]of Object.entries(rows)){const start={easy:61,medium:129,hard:197}[level];fs.appendFileSync(`${d}/${level}.psv`,items.map((r,i)=>[String(start+i).padStart(3,'0'),...r].join('|')).join('\n')+'\n');}
