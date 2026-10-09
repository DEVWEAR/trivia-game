const fs=require('fs'),d='content/international_music';
const sources=[
['psy','YG Entertainment supplied recording credits','https://www.youtube.com/watch?v=4AgDYTuZWOw','Gangnam Style by PSY; PSY SIX RULES Pt.1; co-composer Yoo Gun-hyung.'],
['ricky','Recording Academy — Ricky Martin songwriters','https://www.grammy.com/artists/desmond-child/1577/','Livin La Vida Loca performer Ricky Martin; songwriters Desmond Child and Robi Rosa.'],
['rickyalbum','Apple Music — Ricky Martin 1999','https://music.apple.com/us/album/ricky-martin/192821565','1999 self-titled English-language album includes Livin La Vida Loca.'],
['selenaalbum','Label-supplied Spotify — Entre A Mi Mundo','https://open.spotify.com/embed/album/02fBX9fLFfOG2v33oZo73z','Selena; Como La Flor included on Entre A Mi Mundo.'],
['selenawriter','Apple Music — Como La Flor work credits','https://music.apple.com/us/song/1442940778','Como La Flor songwriter Pete Astudillo, alongside A.B. Quintanilla. Live recording not mistaken for first studio release.'],
['juanes','Apple/Shazam licensed recording credits','https://www.shazam.com/song/1440652265/la-camisa-negra','Juanes La Camisa Negra on Mi Sangre; producer Gustavo Santaolalla.'],
['badbunny','Recording Academy — Dakiti 2021 performance','https://www.grammy.com/news/watch-bad-bunny-jhay-cortez-shine-dakiti-performance-2021-grammy-awards-show/','Bad Bunny and Jhay Cortez; Dakiti from El Ultimo Tour Del Mundo.'],
['dakitivideo','Company 3 — Dakiti production portfolio','https://www.company3.com/videos/dakiti/','Primary post-production portfolio: director Stillz.'],
['rosalia','Recording Academy — Malamente 2018 awards','https://www.grammy.com/news/rosalia-wins-latin-grammy-malamente-2018-rewind-speech-video/','Rosalia Malamente from El Mal Querer.'],
['rosaliawriters','Latin Recording Academy — Rosalia award credits','https://www.latingrammy.com/es/artists/rosalia-33084/','Malamente co-writers Pablo Diaz-Reixa and C. Tangana alongside Rosalia.'],
['stromae','Stromae official biography','https://stromae.com/','Alors on danse from Cheese; born Paul Van Haver.'],
['piafwork','Bibliotheque nationale de France — La Vie en rose catalogue','https://catalogue.bnf.fr/affiner.do?afficheRegroup=false&critereRecherche=&index=AUT3&listeAffinages=FacDat_1900.0%211999.9%3BFacDat_1940.0%211949.8%3BFacOeu_14725988&motRecherche=&nbResultParPage=100&numNotice=13896809&triResultParPage=0&trouveDansFiltre=NoticePUB&typeNotice=','Edith Piaf words; music Louiguy.'],
['piafnickname','Bibliotheque nationale de France — Piaf biography selection','https://salleovale.bnf.fr/fr/selections-thematiques/piaf-un-mythe-francais-biographie-robert-belleret','Louis Leplee launched her career and created stage name Mome Piaf.']
];for(const [k,n,u,e]of sources)fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');
const rows={easy:[
['song:gangnamstyle:performer','psy','من الفنان الكوري صاحب «غانغنام ستايل»؟','Which Korean artist performs Gangnam Style?','ساي','PSY'],
['song:livinvidaloca:performer','ricky','من المطرب صاحب «ليفين لا فيدا لوكا»؟',"Which singer performs Livin' La Vida Loca?",'ريكي مارتن','Ricky Martin'],
['song:comolaflor:performer','selenaalbum','من المطربة صاحبة أغنية «كومو لا فلور»؟','Which singer performs Como La Flor?','سيلينا','Selena'],
['song:camisanegra:performer','juanes','من المطرب الكولومبي صاحب «لا كاميسا نيغرا»؟','Which Colombian singer performs La Camisa Negra?','خوانيس','Juanes'],
['song:dakiti:mainartist','badbunny','أي فنان بورتوريكي أصدر «داكيتي» مع جاي كورتيز؟','Which Puerto Rican artist released Dakiti with Jhay Cortez?','باد باني','Bad Bunny'],
['song:malamente:performer','rosalia','من المطربة الإسبانية صاحبة «مالامينتي»؟','Which Spanish singer performs Malamente?','روساليا','Rosalía'],
['song:alorsondanse:performer','stromae','من الفنان البلجيكي صاحب «ألور أون دانس»؟','Which Belgian artist performs Alors on danse?','ستروماي','Stromae'],
['song:lavieenrose:originalsinger','piafwork','أي مطربة فرنسية اشتهرت بتسجيل «لا في أون روز» الأصلي؟','Which French singer is known for the original La Vie en rose recording?','إديث بياف','Édith Piaf']],
medium:[
['song:gangnamstyle:originalalbum','psy','في أي جزء من ألبوم «ساي سيكس رولز» صدرت «غانغنام ستايل»؟','On which part of PSY Six Rules was Gangnam Style released?','الجزء الأول','Part 1'],
['song:livinvidaloca:album','rickyalbum','ما اسم ألبوم ريكي مارتن الإنجليزي لعام 1999 الذي يضم «ليفين لا فيدا لوكا»؟',"What is Ricky Martin's 1999 English-language album containing Livin' La Vida Loca called?",'ريكي مارتن','Ricky Martin'],
['song:comolaflor:album','selenaalbum','ما ألبوم سيلينا الذي يضم «كومو لا فلور»؟','Which Selena album contains Como La Flor?','إنتري آ مي موندو','Entre A Mi Mundo'],
['song:camisanegra:album','juanes','في أي ألبوم لخوانيس صدرت «لا كاميسا نيغرا»؟','On which Juanes album was La Camisa Negra released?','مي سانغري','Mi Sangre'],
['song:dakiti:album','badbunny','ما ألبوم باد باني الذي يضم «داكيتي»؟','Which Bad Bunny album contains Dakiti?','إل أولتيمو تور ديل موندو','El Último Tour Del Mundo'],
['song:malamente:album','rosalia','ما ألبوم روساليا الذي يضم «مالامينتي»؟','Which Rosalía album contains Malamente?','إل مال كيرير','El Mal Querer'],
['song:alorsondanse:album','stromae','ما ألبوم ستروماي الأول الذي يضم «ألور أون دانس»؟','What is Stromae\'s debut album containing Alors on danse called?','تشيز','Cheese'],
['artist:piaf:nickname','piafnickname','بأي اسم مسرحي اشتهرت إديث بياف، يبدأ بكلمة «لا موم»؟','What stage name beginning with La Môme was Édith Piaf known by?','لا موم بياف','La Môme Piaf']],
hard:[
['song:gangnamstyle:cocomposer','psy','من شارك ساي تلحين «غانغنام ستايل»؟','Who co-composed Gangnam Style with PSY?','يو غُن هيونغ','Yoo Gun-hyung'],
['song:livinvidaloca:writers','ricky','من كاتبا أغنية «ليفين لا فيدا لوكا» لريكي مارتن؟',"Who wrote Ricky Martin's Livin' La Vida Loca?",'ديزموند تشايلد وروبي روزا','Desmond Child and Robi Rosa'],
['song:comolaflor:cowriter','selenawriter','من شارك إيه بي كوينتانيلا كتابة «كومو لا فلور» لسيلينا؟',"Who co-wrote Selena's Como La Flor with A.B. Quintanilla?",'بيت أستوديو','Pete Astudillo'],
['song:camisanegra:producer','juanes','أي منتج أرجنتيني شارك خوانيس إنتاج «لا كاميسا نيغرا»؟',"Which Argentine producer worked with Juanes on La Camisa Negra?",'غوستافو سانتاولالا','Gustavo Santaolalla'],
['song:dakiti:videodirector','dakitivideo','من أخرج كليب «داكيتي» لباد باني وجاي كورتيز؟','Who directed Bad Bunny and Jhay Cortez\'s Dakiti video?','ستيلز','Stillz'],
['song:malamente:cowriters','rosaliawriters','من شاركا روساليا كتابة «مالامينتي»، وفق اعتماد لاتين غرامي؟','Who co-wrote Malamente with Rosalía, according to its Latin Grammy credit?','بابلو دياز ريخا وسي تانغانا','Pablo Diaz-Reixa and C. Tangana'],
['artist:stromae:birthname','stromae','ما اسم ستروماي الحقيقي؟',"What is Stromae's birth name?",'بول فان هافر','Paul Van Haver'],
['song:lavieenrose:composer','piafwork','من لحّن «لا في أون روز» التي كتبت كلماتها إديث بياف؟','Who composed La Vie en rose, whose lyrics were written by Édith Piaf?','لويغي','Louiguy']]};
for(const [level,items]of Object.entries(rows)){const start={easy:53,medium:121,hard:189}[level];fs.appendFileSync(`${d}/${level}.psv`,items.map((r,i)=>[String(start+i).padStart(3,'0'),...r].join('|')).join('\n')+'\n');}
