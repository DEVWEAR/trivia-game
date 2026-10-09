const fs=require('fs');
for(const name of ['generate_saudi_music.ps1','validate_saudi_music.ps1','saudi_music_similarity.js','saudi_music_shared_answers.js','record_saudi_music_editorial_review.js']){
let s=fs.readFileSync('tool/'+name,'utf8').replaceAll('saudi_music','egyptian_music').replaceAll('Saudi Music','Egyptian Music');
if(name.includes('similarity')||name.includes('shared_answers'))s=s.replace("'kuwaiti_music']","'kuwaiti_music','saudi_music']");
fs.writeFileSync('tool/'+name.replaceAll('saudi_music','egyptian_music'),s);
}
let s=fs.readFileSync('content/egyptian_music/easy.psv','utf8');
const edits={
'040':['من صاحب أغنية «فاضي شوية»؟','Who sings Fady Shewaya?'],
'041':['أي فرقة مصرية قدّمت أغنية «أنا نجم»؟','Which Egyptian band released Ana Negm?'],
'042':['من المطرب صاحب أغنية «منايا»؟','Who sings Monaya?'],
'045':['من صاحب أغنية «وماله»؟','Who sings We Malo?'],
'046':['من المطرب الذي غنّى «قمرين»؟','Which singer performs Amarain?'],
'049':['من المطرب الذي غنّى «كامننا» في تسجيلها الأصلي؟','Which singer performed the original recording of Kamannana?'],
'051':['من صاحب أغنية «فاكرك يا ناسيني»؟','Who sings Fakrak Ya Nasini?']};
s=s.split(/\r?\n/).map(l=>{let a=l.split('|');if(edits[a[0]])[a[3],a[4]]=edits[a[0]];return a.join('|');}).join('\n');fs.writeFileSync('content/egyptian_music/easy.psv',s);
