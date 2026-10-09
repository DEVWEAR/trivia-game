const fs=require('fs');
for(const n of ['generate_international_music.ps1','validate_international_music.ps1','international_music_similarity.js','international_music_shared_answers.js','record_international_music_editorial_review.js','protect_international_music.ps1']){
let s=fs.readFileSync('tool/'+n,'utf8').replaceAll('international_music','old_school_music').replaceAll('International Music','Old School Music').replaceAll('INTERNATIONAL_MUSIC','OLD_SCHOOL_MUSIC');
if(n.includes('similarity')||n.includes('shared_answers'))s=s.replace("'arabic_music']","'arabic_music','international_music']");
fs.writeFileSync('tool/'+n.replaceAll('international_music','old_school_music'),s);
}
const dir='content/old_school_music',read=t=>fs.readFileSync(dir+'/'+t+'.psv','utf8').trim().split(/\r?\n/).map(l=>l.split('|'));
const rows={easy:read('easy'),medium:read('medium'),hard:read('hard')};
let e=rows.easy.find(r=>r[1]==='song:unchainedmelody:performer');if(!e)e=rows.easy.find(r=>r[3]?.includes('أنتشيند'));e[3]='أي ثنائي غنّى التسجيل الشهير لـ«أنتشيند ميلودي» الذي عاد للنجاح عام 1990؟';e[4]='Which duo’s famous Unchained Melody recording regained popularity in 1990?';
let am=rows.easy.find(r=>r[1]==='song:amore:meaning');am.splice(1,6,'song:amore:performer','deanamore','من المغنّي صاحب تسجيل «ذاتس أموري» الكلاسيكي؟','Who sings the classic recording of That’s Amore?','دين مارتن','Dean Martin');
fs.appendFileSync(dir+'/sources.psv',['deanamore','Apple Shazam — recording metadata',"https://www.shazam.com/song/1743344201/thats-amore",'Retrieved or indexed 2026-10-08: Thats Amore performer Dean Martin.'].join('|')+'\n');
const hi=rows.hard.findIndex(r=>r[1]==='song:ayazon:poet'||r[3]?.includes('أيظن')),mi=rows.medium.findIndex(r=>r[1]==='song:zahab:film');
const h=rows.hard[hi].slice(1),m=rows.medium[mi].slice(1);rows.hard[hi].splice(1,6,...m);rows.medium[mi].splice(1,6,...h);
let sc=rows.hard.find(r=>r[1]==='song:sakan:lyricist');sc.splice(1,6,'song:sakan:scoremaqam','sakan','ما المقام الأساسي لقصيدة فيروز «سكن الليل» بحسب نوتتها المنشورة؟','What is the principal maqam of Fairuz’s Sakan Al Lail according to its published score?','الكرد','Kurd');
for(const[t,rs]of Object.entries(rows))fs.writeFileSync(dir+'/'+t+'.psv',rs.map(r=>r.join('|')).join('\n')+'\n');
for(const file of ['lib/data/question_bank.dart','lib/data/playable_category_registry.dart']){let s=fs.readFileSync(file,'utf8');const old="import 'questions/international_music_final.dart';";s=s.replace(old,old+"\nimport 'questions/old_school_music_final.dart';");
if(file.includes('question_bank'))s=s.replace("  'international_music': international_musicFinalQuestions,","  'international_music': international_musicFinalQuestions,\n  'old_school_music': old_school_musicFinalQuestions,");
else s=s.replace("  PlayableCategory('international_music', '🌎', 'أغاني أجنبية', 'International Music', international_musicFinalQuestions),","  PlayableCategory('international_music', '🌎', 'أغاني أجنبية', 'International Music', international_musicFinalQuestions),\n  PlayableCategory('old_school_music', '📻', 'أغاني الزمن الجميل', 'Old School Music', old_school_musicFinalQuestions),");
fs.writeFileSync(file,s);
}

