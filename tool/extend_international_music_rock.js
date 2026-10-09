const fs=require('fs'),dir='content/international_music';
const sources=[
['nirvana','Recording Academy — Nevermind history','https://www.grammy.com/news/nirvanas-era-defining-nevermind-record/','Nirvana, Smells Like Teen Spirit, Nevermind; producer Butch Vig.'],
['eagles','Recording Academy — Record Of The Year 1978','https://www.grammy.com/awards/categories/record-of-the-year/1978/','Eagles won Record Of The Year with Hotel California at the 1978 ceremony; producer Bill Szymczyk.'],
['pinkfloyd','Pink Floyd official — The Dark Side Of The Moon credits','https://www.pinkfloyd.com/albums/the-dark-side-of-the-moon-50th-anniversary/','Original album has Money; Pink Floyd produces, Alan Parsons engineers. 2023 remaster release is not treated as the original release.'],
['zeppelin','Rock and Roll Hall of Fame — Led Zeppelin IV','https://shop.rockhall.com/products/vinyl-lp-led-zeppelin-iv','Museum catalog: original untitled album commonly called IV; includes Stairway To Heaven; produced by guitarist Jimmy Page.'],
['metallica','Metallica official — Black Album deluxe production credits','https://www.metallica.com/releases/reissues/metallica-remastered-deluxe-box-set-reissue.html','Original self-titled Metallica album known as the Black Album; Enter Sandman included; orchestration on Nothing Else Matters by Michael Kamen.'],
['greenday','Recording Academy — Record Of The Year 2006','https://www.grammy.com/awards/categories/record-of-the-year/2006/','Green Day won with Boulevard Of Broken Dreams; co-producers Rob Cavallo and Green Day.'],
['gdliner','American Idiot published album liner credits','https://albumlinernotes.com/American_Idiot.html','Reproduced Reprise album credits and tracklist identify Boulevard Of Broken Dreams on American Idiot. Lyrics excluded.'],
['linkin','Linkin Park official band biography','https://linkinpark.com/about','In The End single from first full-length Hybrid Theory, released 2000.'],
['linkinproducer','Recording Academy — Hybrid Theory retrospective','https://www.grammy.com/news/what-it-meant-me-will-eventually-be-memory-linkin-parks-hybrid-theory-turns-20/','Hybrid Theory production by Don Gilmore.'],
['amy','Recording Academy — Back To Black history','https://www.grammy.com/news/deep-10-amy-winehouses-back-to-black/','Amy Winehouse sings Rehab on Back To Black; album producers Mark Ronson and Salaam Remi.']
];
for(const [k,n,u,e]of sources)fs.appendFileSync(`${dir}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const data={easy:`013|song:teen_spirit:performer|nirvana|أي فرقة غنّت «سميلز لايك تين سبيريت»؟|Which band sings Smells Like Teen Spirit?|نيرفانا|Nirvana
014|song:hotelcalifornia:performer|eagles|أي فرقة قدّمت التسجيل الشهير لأغنية «هوتيل كاليفورنيا»؟|Which band made the famous recording of Hotel California?|إيغلز|Eagles
015|album:darkside:artist|pinkfloyd|أي فرقة أصدرت ألبوم «ذا دارك سايد أوف ذا مون»؟|Which band released The Dark Side Of The Moon?|بينك فلويد|Pink Floyd
016|song:stairway:performer|zeppelin|أي فرقة قدّمت «ستيرواي تو هيفن»؟|Which band performs Stairway To Heaven?|ليد زيبلين|Led Zeppelin
017|song:entersandman:performer|metallica|أي فرقة ميتال غنّت «إنتر ساندمان»؟|Which metal band sings Enter Sandman?|ميتاليكا|Metallica
018|song:boulevard:performer|greenday|أي فرقة غنّت «بوليفارد أوف بروكن دريمز»؟|Which band sings Boulevard Of Broken Dreams?|غرين داي|Green Day
019|song:intheend:performer|linkin|أي فرقة قدّمت «إن ذا إند» على ألبومها الأول؟|Which band released In The End on its debut album?|لينكين بارك|Linkin Park
020|song:rehab:performer|amy|من المطربة البريطانية صاحبة أغنية «ريهاب»؟|Which British singer performs Rehab?|إيمي واينهاوس|Amy Winehouse`,
medium:`081|song:teen_spirit:album|nirvana|في أي ألبوم لنيرفانا صدرت «سميلز لايك تين سبيريت»؟|On which Nirvana album was Smells Like Teen Spirit released?|نيفرمايند|Nevermind
082|award:hotelcalifornia:recordyear|eagles|في أي عام فازت «هوتيل كاليفورنيا» بغرامي تسجيل العام؟|In which year did Hotel California win the Grammy for Record Of The Year?|1978|1978
083|song:money:album|pinkfloyd|أي ألبوم لبينك فلويد يضم أغنية «مَني»؟|Which Pink Floyd album contains Money?|ذا دارك سايد أوف ذا مون|The Dark Side Of The Moon
084|song:stairway:album|zeppelin|بأي رقم يُعرف ألبوم ليد زيبلين الذي يضم «ستيرواي تو هيفن»؟|By which number is the Led Zeppelin album containing Stairway To Heaven known?|الرابع (IV)|IV
085|album:metallica:nickname|metallica|بأي لقب يُعرف ألبوم ميتاليكا الذي يحمل اسم الفرقة والصادر عام 1991؟|What nickname is used for Metallica's self-titled 1991 album?|الألبوم الأسود|The Black Album
086|song:boulevard:album|gdliner|في أي ألبوم لغرين داي صدرت «بوليفارد أوف بروكن دريمز»؟|On which Green Day album was Boulevard Of Broken Dreams released?|أمريكان إيديوت|American Idiot
087|song:intheend:album|linkin|في أي ألبوم للينكين بارك صدرت «إن ذا إند»؟|On which Linkin Park album was In The End released?|هايبرد ثيوري|Hybrid Theory
088|song:rehab:album|amy|في أي ألبوم لإيمي واينهاوس صدرت «ريهاب»؟|On which Amy Winehouse album was Rehab released?|باك تو بلاك|Back To Black`,
hard:`149|album:nevermind:producer|nirvana|من أنتج ألبوم نيرفانا «نيفرمايند»؟|Who produced Nirvana's Nevermind?|بوتش فيغ|Butch Vig
150|song:hotelcalifornia:producer|eagles|من أنتج تسجيل إيغلز لأغنية «هوتيل كاليفورنيا»؟|Who produced the Eagles recording of Hotel California?|بيل شيمتشيك|Bill Szymczyk
151|album:darkside:engineer|pinkfloyd|من مهندس التسجيل الأصلي لألبوم «ذا دارك سايد أوف ذا مون»؟|Who engineered the original recording of The Dark Side Of The Moon?|آلان بارسونز|Alan Parsons
152|album:zeppeliniv:producer|zeppelin|أي عضو في ليد زيبلين أنتج ألبوم الفرقة الرابع؟|Which Led Zeppelin member produced the band's fourth album?|جيمي بيج|Jimmy Page
153|song:nothingelse:orchestrator|metallica|من وضع التوزيع الأوركسترالي لأغنية ميتاليكا «نَثينغ إلس ماترز»؟|Who arranged the orchestration on Metallica's Nothing Else Matters?|مايكل كامن|Michael Kamen
154|song:boulevard:coproducer|greenday|من شارك غرين داي إنتاج «بوليفارد أوف بروكن دريمز»؟|Who co-produced Boulevard Of Broken Dreams with Green Day?|روب كافالو|Rob Cavallo
155|album:hybridtheory:producer|linkinproducer|من أنتج ألبوم لينكين بارك الأول «هايبرد ثيوري»؟|Who produced Linkin Park's debut album Hybrid Theory?|دون غيلمور|Don Gilmore
156|album:backtoblack:producers|amy|من المنتجان اللذان عملا على ألبوم إيمي واينهاوس «باك تو بلاك»؟|Which two producers worked on Amy Winehouse's Back To Black?|مارك رونسون وسلام ريمي|Mark Ronson and Salaam Remi`};
for(const [t,s]of Object.entries(data))fs.appendFileSync(`${dir}/${t}.psv`,s+'\n');console.log('Added 24; total 60 drafts.');
