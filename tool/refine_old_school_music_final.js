const fs=require('fs'),d='content/old_school_music';
let s=fs.readFileSync(d+'/sources.psv','utf8').split(/\r?\n/).map(l=>{let r=l.split('|');if(r[0]==='haramt')r=['haramt','Apple Shazam — original Warda release credits',"https://www.shazam.com/song/770101904/haramt-ahebak",'Retrieved or indexed 2026-10-08: Warda; music Salah El Sharnouby; lyrics Omar Batisha. Cross-checked published educational score and lyricists first-person Al Ahram interview; erroneous 2011 concert report credit rejected.'];if(r[0]==='dollycredits')r=['dollycredits','Apple Music — Jolene recording credits',"https://music.apple.com/us/song/411940289",'Retrieved or indexed 2026-10-08: Dolly Parton vocals/songwriter/executive producer; Bob Ferguson producer. Producer and executive-producer roles distinguished.'];return r.join('|');}).join('\n');fs.writeFileSync(d+'/sources.psv',s);
for(const t of ['easy','medium','hard']){let rs=fs.readFileSync(d+'/'+t+'.psv','utf8').trim().split(/\r?\n/).map(l=>l.split('|'));for(const r of rs){
if(r[1]==='song:haramt:lyricist'){r[5]='عمر بطيشة';r[6]='Omar Batisha';}
if(r[1]==='song:jolene:executiveproducer'){r[1]='song:jolene:producer';r[3]='من أنتج تسجيل دولي بارتون الكلاسيكي لأغنية «جولين»؟';r[4]='Who produced Dolly Parton’s classic Jolene recording?';}
if(r[1]==='artist:jouwini:documentary'){r[3]='ما الفيلم الوثائقي الذي قدّم سيرة الهادي الجويني عام 2017؟';r[4]='Which 2017 documentary tells Hedi Jouini’s life story?';}
if(r[1]==='song:mackknife:ellaberlin'){r[3]='أي مغنّية جاز قدّمت التسجيل الحي الشهير لـ«ماك ذا نايف» عام 1960؟';r[4]='Which jazz singer made the famous 1960 live recording of Mack The Knife?';}
if(r[3]?.includes('لـأم كلثوم'))r[3]=r[3].replace('لـأم كلثوم','لأم كلثوم');
if(r[3]?.includes('لـعبد الحليم'))r[3]=r[3].replace('لـعبد الحليم','لعبد الحليم');
if(r[3]?.includes('لـذكرى'))r[3]=r[3].replace('لـذكرى','لذكرى');
if(r[3]?.includes('لـياس'))r[3]=r[3].replace('لـياس','لياس');
r[3]=r[3]?.replace('غنّاها شادية','غنّتها شادية').replace('غنّاها أم كلثوم','غنّتها أم كلثوم').replace('غنّاها صباح','غنّتها صباح').replace('غنّاها ذكرى','غنّتها ذكرى');
}fs.writeFileSync(d+'/'+t+'.psv',rs.map(r=>r.join('|')).join('\n')+'\n');}

