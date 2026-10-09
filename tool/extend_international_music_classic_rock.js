const fs=require('fs'),d='content/international_music';
const src=[
['oasis','Oasis official — Wonderwall','https://oasisinet.com/music/wonderwall/','Wonderwall; producers Owen Morris and Noel Gallagher.'],
['oasisalbum','Oasis official — Morning Glory','https://oasisinet.com/music/whats-the-story-morning-glory/','Wonderwall on (Whats The Story) Morning Glory.'],
['bonjovi','Bon Jovi official archive — Slippery When Wet','https://backstage.bonjovi.com/exhibits/slippery-when-wet','Livin On A Prayer; Slippery When Wet; producer Bruce Fairbairn.'],
['acdc','AC/DC official — Back in Black','https://store.acdc.com/collections/back-in-black-anniversary-collection','Back in Black; producer Robert John Mutt Lange.'],
['acdcbrian','AC/DC official — July 1980','https://www.acdc.com/on-this-day-1980-5/','Back in Black album era with Brian Johnson.'],
['journey','Journey official discography','https://journeymusic.com/','Dont Stop Believin on Escape.'],
['journeycredits','Apple Music — recording credits for Escape','https://music.apple.com/us/song/160024899','Original Escape recording producers Kevin Elson and Mike Stone. Compilation date is not used as original album date.'],
['guns','Recording Academy — Appetite for Destruction','https://live.grammy.com/news/guns-n-roses-appetite-destruction-record','Guns N Roses; Sweet Child O Mine; Appetite for Destruction; producer Mike Clink.'],
['police','Police official — Synchronicity anniversary','https://thepolice.com/synchronicity-40th-anniversary-editions/','Every Breath You Take on Synchronicity.'],
['policeprod','Recording Academy — Synchronicity','https://www.grammy.com/news/police-synchronicity-record/','Hugh Padgham album producer and engineer.'],
['rem','R.E.M. official — Automatic for the People liner notes','https://remhq.com/music/automatic-for-the-people/','Everybody Hurts; album Automatic for the People; orchestral arrangements John Paul Jones.'],
['fleetwood','Rhino — Dreams retrospective','https://www.rhino.com/article/once-upon-a-time-in-the-top-spot-fleetwood-mac-dreams-0','Dreams by Fleetwood Mac from Rumours; producers Ken Caillat, Richard Dashut and band.']
];for(const [k,n,u,e]of src)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const rows={easy:[
['song:wonderwall:performer','oasis','أي فرقة بريطانية غنّت «ووندروول»؟','Which British band sings Wonderwall?','أواسيس','Oasis'],
['song:livinprayer:performer','bonjovi','أي فرقة غنّت «ليفين أون أ بريير»؟',"Which band sings Livin' On A Prayer?",'بون جوفي','Bon Jovi'],
['album:backinblack:artist','acdc','أي فرقة روك أصدرت ألبوم «باك إن بلاك»؟','Which rock band released Back in Black?','إيه سي/دي سي','AC/DC'],
['song:dontstopbelievin:performer','journey','أي فرقة اشتهرت بأغنية «دونت ستوب بيليفين»؟',"Which band is known for Don't Stop Believin'?",'جورني','Journey'],
['song:sweetchild:performer','guns','أي فرقة غنّت «سويت تشايلد أو ماين»؟',"Which band sings Sweet Child O' Mine?",'غنز إن روزز',"Guns N' Roses"],
['song:everybreath:performer','police','أي فرقة غنّت «إفري بريث يو تيك»؟','Which band sings Every Breath You Take?','ذا بوليس','The Police'],
['song:everybodyhurts:performer','rem','أي فرقة أصدرت «إفري بادي هيرتس»؟','Which band released Everybody Hurts?','آر إي إم','R.E.M.'],
['song:dreams:performer','fleetwood','أي فرقة أصدرت «دريمز» ضمن ألبوم «رومرز»؟','Which band released Dreams on Rumours?','فليتوود ماك','Fleetwood Mac']],
medium:[
['song:wonderwall:album','oasisalbum','ما ألبوم أواسيس الذي يضم «ووندروول»؟','Which Oasis album contains Wonderwall?','واتس ذا ستوري مورنينغ غلوري؟',"(What's The Story) Morning Glory?"],
['song:livinprayer:album','bonjovi','ما ألبوم بون جوفي الذي يضم «ليفين أون أ بريير»؟',"Which Bon Jovi album contains Livin' On A Prayer?",'سليبري وِن وِت','Slippery When Wet'],
['album:backinblack:leadsinger','acdcbrian','من المغنّي الرئيسي لإيه سي/دي سي في ألبوم «باك إن بلاك»؟',"Who is AC/DC's lead singer on Back in Black?",'برايان جونسون','Brian Johnson'],
['song:dontstopbelievin:album','journey','في أي ألبوم لجورني صدرت «دونت ستوب بيليفين»؟',"On which Journey album was Don't Stop Believin' released?",'إسكيب','Escape'],
['song:sweetchild:album','guns','ما ألبوم غنز إن روزز الأول الذي يضم «سويت تشايلد أو ماين»؟',"What is Guns N' Roses' debut album containing Sweet Child O' Mine called?",'أبِتايت فور ديستراكشن','Appetite for Destruction'],
['song:everybreath:album','police','ما ألبوم ذا بوليس الذي يضم «إفري بريث يو تيك»؟','Which Police album contains Every Breath You Take?','سينكرونيسيتي','Synchronicity'],
['song:everybodyhurts:album','rem','ما ألبوم آر إي إم الذي يضم «إفري بادي هيرتس»؟','Which R.E.M. album contains Everybody Hurts?','أوتوماتيك فور ذا بيبل','Automatic for the People'],
['song:dreams:album','fleetwood','ما ألبوم فليتوود ماك الذي يضم «دريمز»؟','Which Fleetwood Mac album contains Dreams?','رومرز','Rumours']],
hard:[
['song:wonderwall:coproducer','oasis','من شارك نويل غالاغر إنتاج تسجيل «ووندروول»؟','Who co-produced the Wonderwall recording with Noel Gallagher?','أوين موريس','Owen Morris'],
['album:slipperywhenwet:producer','bonjovi','من أنتج ألبوم بون جوفي «سليبري وِن وِت»؟',"Who produced Bon Jovi's Slippery When Wet?",'بروس فيربيرن','Bruce Fairbairn'],
['album:backinblack:producer','acdc','من أنتج ألبوم إيه سي/دي سي «باك إن بلاك»؟',"Who produced AC/DC's Back in Black?",'روبرت جون «مات» لانغ','Robert John "Mutt" Lange'],
['song:escape:producers','journeycredits','من المنتجان المعتمدان لتسجيل أغنية جورني «إسكيب»؟',"Who are the two credited producers of Journey's Escape recording?",'كيفن إلسون ومايك ستون','Kevin Elson and Mike Stone'],
['album:appetitedestruction:producer','guns','من أنتج ألبوم غنز إن روزز «أبِتايت فور ديستراكشن»؟',"Who produced Guns N' Roses' Appetite for Destruction?",'مايك كلينك','Mike Clink'],
['album:synchronicity:coproducer','policeprod','من المنتج ومهندس الصوت الذي عمل مع ذا بوليس على «سينكرونيسيتي»؟','Which producer and engineer worked with the Police on Synchronicity?','هيو بادغام','Hugh Padgham'],
['song:everybodyhurts:orchestralarranger','rem','من تولّى التوزيع الأوركسترالي لأغنية آر إي إم «إفري بادي هيرتس»؟',"Who arranged the orchestration for R.E.M.'s Everybody Hurts?",'جون بول جونز','John Paul Jones'],
['song:dreams:otherproducers','fleetwood','من شاركا فليتوود ماك إنتاج تسجيل «دريمز»؟','Which two producers worked with Fleetwood Mac on the Dreams recording?','كين كايلا وريتشارد داشوت','Ken Caillat and Richard Dashut']]};
for(const [level,items]of Object.entries(rows)){const start={easy:45,medium:113,hard:181}[level];fs.appendFileSync(`${d}/${level}.psv`,items.map((r,i)=>[String(start+i).padStart(3,'0'),...r].join('|')).join('\n')+'\n');}
