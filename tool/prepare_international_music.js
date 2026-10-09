const fs=require('fs');
for(const name of ['generate_arabic_music.ps1','validate_arabic_music.ps1','arabic_music_similarity.js','arabic_music_shared_answers.js','record_arabic_music_editorial_review.js']){
let s=fs.readFileSync('tool/'+name,'utf8').replaceAll('arabic_music','international_music').replaceAll('Arabic Music','International Music');
if(name.includes('similarity')||name.includes('shared_answers'))s=s.replace("'egyptian_music']","'egyptian_music','arabic_music']");
fs.writeFileSync('tool/'+name.replaceAll('arabic_music','international_music'),s);
}
const changes={easy:{
'052':['أي فرقة اشتهرت بأغنية «دريمز» عام 1977؟','Which band is known for the 1977 song Dreams?'],
'061':['من عازف الجاز والمغنّي صاحب تسجيل «وات أ ووندرفُل وورلد» الأصلي؟','Which jazz musician and singer made the original What a Wonderful World recording?'],
'062':['من المغنّي صاحب تسجيل «ماي واي» الكلاسيكي الذي اقتبس موسيقاه من أغنية فرنسية؟','Which singer made the classic My Way recording based on a French melody?'],
'063':['من غنّى النسخة الأصلية من «كانت هِلب فولينغ إن لاف»؟',"Who sang the original Can't Help Falling in Love?"],
'066':['اشتهر ديف بروبيك بالعزف على أي آلة موسيقية؟','Which instrument is Dave Brubeck known for playing?','البيانو','Piano'],
'067':['من أدّت الغناء بصوت إلسا في النسخة الإنجليزية الأصلية من «لِت إت غو»؟','Who sang Let It Go as Elsa in its original English version?'],
'068':['من المطربة صاحبة أغنية «آي هاف ناثينغ»؟','Which singer performs I Have Nothing?']},medium:{
'121':['ما الألبوم الأصلي الذي يضم «غانغنام ستايل» لساي؟',"What is PSY's original album containing Gangnam Style called?",'ساي سيكس رولز، الجزء الأول','PSY Six Rules, Part 1'],
'128':['ما اللقب المسرحي المعروف لإديث بياف؟',"What is Édith Piaf's well-known stage nickname?",'لا موم بياف','La Môme Piaf']}};
for(const [tier,byid]of Object.entries(changes)){
let s=fs.readFileSync(`content/international_music/${tier}.psv`,'utf8').split(/\r?\n/).map(l=>{const a=l.split('|'),c=byid[a[0]];if(c){a[3]=c[0];a[4]=c[1];if(c.length===4){a[5]=c[2];a[6]=c[3];}if(a[0]==='066'){a[1]='artist:brubeck:instrument';a[2]='brubeckpiano';}}return a.join('|');}).join('\n');
fs.writeFileSync(`content/international_music/${tier}.psv`,s);
}
