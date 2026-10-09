const fs=require('fs');
for(const name of ['generate_egyptian_music.ps1','validate_egyptian_music.ps1','egyptian_music_similarity.js','egyptian_music_shared_answers.js','record_egyptian_music_editorial_review.js']){
let s=fs.readFileSync('tool/'+name,'utf8').replaceAll('egyptian_music','arabic_music').replaceAll('Egyptian Music','Arabic Music');
if(name.includes('similarity')||name.includes('shared_answers'))s=s.replace("'saudi_music']","'saudi_music','egyptian_music']");
if(name.includes('editorial_review'))s=s.replace('The review excluded protected Boshret Kheir credits and the Umm Kulthum influence on Awadh Doukhi while authoring.','The review compares every completed bank, including Egyptian Music; ambiguous or unsupported release credits were excluded during research.').replace('a a composer','a composer');
fs.writeFileSync('tool/'+name.replaceAll('egyptian_music','arabic_music'),s);
}
let s=fs.readFileSync('content/arabic_music/easy.psv','utf8');
s=s.split(/\r?\n/).map(l=>{let a=l.split('|');if(a[0]==='031'){a[3]='من المطربة صاحبة أغنية «الليالي»؟';a[4]='Which singer performs El Layali?';}return a.join('|');}).join('\n');fs.writeFileSync('content/arabic_music/easy.psv',s);
s=fs.readFileSync('content/arabic_music/sources.psv','utf8').replace('Question uses the explicitly stated Hamid Cheriet/Idir identity, not an inferred song language.','Questions use the explicitly stated Hamid Cheriet/Idir identity and the 100% Arabica film costarring Khaled and Cheb Mami, not an inferred song language.');fs.writeFileSync('content/arabic_music/sources.psv',s);
