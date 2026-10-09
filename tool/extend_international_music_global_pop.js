const fs=require('fs'),d='content/international_music';
const sources=[
['olivia','Recording Academy — Olivia Rodrigo artist credits','https://www.grammy.com/artists/olivia-rodrigo/38411/','drivers license by Olivia Rodrigo; debut SOUR; Song Of The Year writing nominees Daniel Nigro and Olivia Rodrigo.'],
['ariana','Recording Academy — Sweetener award','https://www.grammy.com/news/ariana-grande-wins-best-pop-vocal-album-sweetener-2019-grammys/','Ariana Grande; no tears left to cry included on Sweetener.'],
['arianavideo','Universal Music Canada — No Tears Left To Cry release','https://www.universalmusic.ca/2018/04/20/ariana-grande-releases-no-tears-left-cry-today/','Primary label release: music video director Dave Meyers.'],
['weeknd','Apple Music — After Hours album','https://music.apple.com/us/album/after-hours/1499385848','The Weeknd, Blinding Lights from After Hours.'],
['weekndprod','Swedish Government — Oscar Holter musical export profile','https://www.government.se/contentassets/f97de1f8369b4ab9abd0c14bb69bb96c/minister-for-foreign-trade-and-nordic-affairs-anna-hallberg-press-releases-2019-2022.pdf','Government export-prize profile explicitly says Holter and Max Martin wrote and produced Blinding Lights with The Weeknd.'],
['harry','Sony Music Canada — As It Was release','https://www.sonymusic.ca/press_release/harry-styles-single-and-video-out-now-as-it-was','Harry Styles single from Harrys House; Ukrainian director Tanu Muino.'],
['shakira','Official Charts — Hips Dont Lie','https://www.officialcharts.com/songs/shakira-ft-wyclef-jean-hips-dont-lie/','Shakira featuring Wyclef Jean. No changing chart total queried.'],
['shakiragrammy','Recording Academy — Shakira first Grammy','https://www.grammy.com/news/grammy-rewind-shakira-wins-her-first-grammy-best-latin-pop-album-2001/','Shakira first Grammy at 2001 ceremony for MTV Unplugged. Recording year 2000 is not confused with ceremony year.'],
['fonsi','Latin Recording Academy — Luis Fonsi credits','https://www.latingrammy.com/en/artists/luis-fonsi-20285/','Despacito performers Luis Fonsi and Daddy Yankee; remix adds Justin Bieber; original writing winners Fonsi, Daddy Yankee, Erika Ender.'],
['bts','Recording Academy — BTS first-person Dynamite interview','https://www.grammy.com/news/bts-dynamite-interview-new-album-army?amp=','BTS; Dynamite included on Be; lyrics by David Stewart and Jessica Agombar.'],
['blackpink','Recording Academy — BLACKPINK album interview','https://qa.grammy.com/news/blackpink-talk-album-spotlight-shed-k-pop-just-beginning','How You Like That single from The Album; first Coachella performance 2019. Erroneous billion-view claim about Kill This Love is excluded.']
];for(const [k,n,u,e]of sources)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const data={easy:`029|song:driverslicense:performer|olivia|من المطربة صاحبة أغنية «درايفرز لايسنس»؟|Which singer performs drivers license?|أوليفيا رودريغو|Olivia Rodrigo
030|song:notears:performer|ariana|من المطربة صاحبة أغنية «نو تيرز لِفت تو كراي»؟|Which singer performs no tears left to cry?|أريانا غراندي|Ariana Grande
031|song:blindinglights:performer|weeknd|من المطرب صاحب أغنية «بلايندينغ لايتس»؟|Which singer performs Blinding Lights?|ذا ويكند|The Weeknd
032|song:asitwas:performer|harry|من المطرب صاحب أغنية «آز إت واز»؟|Which singer performs As It Was?|هاري ستايلز|Harry Styles
033|song:hipsdontlie:performer|shakira|من المطربة صاحبة أغنية «هيبس دونت لاي»؟|Which singer performs Hips Dont Lie?|شاكيرا|Shakira
034|song:despacito:performers|fonsi|من الثنائي الذي غنّى النسخة الأصلية من «ديسباسيتو»؟|Which duo performs the original Despacito?|لويس فونسي ودادي يانكي|Luis Fonsi and Daddy Yankee
035|song:dynamite:performer|bts|أي فرقة كورية غنّت «دايناميت»؟|Which Korean group sings Dynamite?|بي تي إس|BTS
036|song:howyoulikethat:performer|blackpink|أي فرقة فتيات كورية غنّت «هاو يو لايك ذات»؟|Which Korean girl group sings How You Like That?|بلاكبينك|BLACKPINK`,
medium:`097|song:driverslicense:album|olivia|ما ألبوم أوليفيا رودريغو الأول الذي يضم «درايفرز لايسنس»؟|What is Olivia Rodrigo's debut album containing drivers license called?|ساور|SOUR
098|song:notears:album|ariana|في أي ألبوم لأريانا غراندي صدرت «نو تيرز لِفت تو كراي»؟|On which Ariana Grande album was no tears left to cry released?|سويتِنر|Sweetener
099|song:blindinglights:album|weeknd|أي ألبوم لذا ويكند يضم «بلايندينغ لايتس»؟|Which Weeknd album contains Blinding Lights?|أفتر آورز|After Hours
100|song:asitwas:album|harry|في أي ألبوم لهاري ستايلز صدرت «آز إت واز»؟|On which Harry Styles album was As It Was released?|هاريز هاوس|Harry's House
101|song:hipsdontlie:featuredrapper|shakira|من الرابر الذي شارك شاكيرا غناء «هيبس دونت لاي»؟|Which rapper features on Shakira's Hips Dont Lie?|وايكلف جان|Wyclef Jean
102|song:despacitoremix:addedartist|fonsi|أي مطرب انضم إلى لويس فونسي ودادي يانكي في ريمكس «ديسباسيتو» الشهير؟|Which singer joined Luis Fonsi and Daddy Yankee on the famous Despacito remix?|جاستن بيبر|Justin Bieber
103|song:dynamite:album|bts|في أي ألبوم لبي تي إس أُدرجت «دايناميت»؟|On which BTS album was Dynamite included?|بي|Be
104|song:howyoulikethat:album|blackpink|ما ألبوم بلاكبينك الذي يضم «هاو يو لايك ذات»؟|What is the BLACKPINK album containing How You Like That called?|ذا ألبوم|The Album`,
hard:`165|song:driverslicense:cowriter|olivia|من شارك أوليفيا رودريغو كتابة «درايفرز لايسنس»؟|Who co-wrote drivers license with Olivia Rodrigo?|دان نيغرو|Dan Nigro
166|song:notears:videodirector|arianavideo|من أخرج كليب أريانا غراندي «نو تيرز لِفت تو كراي»؟|Who directed Ariana Grande's no tears left to cry video?|ديف مايرز|Dave Meyers
167|song:blindinglights:coproducers|weekndprod|من المنتجان السويديان اللذان شاركا ذا ويكند إنتاج «بلايندينغ لايتس»؟|Which two Swedish producers worked with The Weeknd on Blinding Lights?|ماكس مارتن وأوسكار هولتر|Max Martin and Oscar Holter
168|song:asitwas:videodirector|harry|من المخرجة الأوكرانية التي أخرجت كليب هاري ستايلز «آز إت واز»؟|Which Ukrainian director made Harry Styles' As It Was video?|تانو موينو|Tanu Muino
169|artist:shakira:firstgrammyalbum|shakiragrammy|لأي ألبوم حصدت شاكيرا أول جائزة غرامي في مسيرتها؟|For which album did Shakira win her first Grammy?|إم تي في أنبلَغد|MTV Unplugged
170|song:despacito:femalecowriter|fonsi|من كاتبة الأغاني التي شاركت لويس فونسي ودادي يانكي كتابة «ديسباسيتو»؟|Which female songwriter co-wrote Despacito with Luis Fonsi and Daddy Yankee?|إريكا إندر|Erika Ender
171|song:dynamite:lyricists|bts|من كاتبا كلمات «دايناميت» لبي تي إس، بحسب مقابلة الفرقة مع أكاديمية التسجيل؟|Who wrote the lyrics of BTS's Dynamite, according to the group's Recording Academy interview?|ديفيد ستيوارت وجيسيكا أغومبار|David Stewart and Jessica Agombar
172|artist:blackpink:firstcoachellayear|blackpink|في أي عام قدّمت بلاكبينك أول عرض لها في مهرجان كوتشيلا؟|In which year did BLACKPINK first perform at Coachella?|2019|2019`};for(const [t,s]of Object.entries(data))fs.appendFileSync(`${d}/${t}.psv`,s+'\n');console.log('Added 24; total 108 drafts.');
