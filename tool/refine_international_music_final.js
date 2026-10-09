const fs=require('fs'),d='content/international_music';
const levels={};for(const t of ['easy','medium','hard'])levels[t]=fs.readFileSync(`${d}/${t}.psv`,'utf8').trim().split(/\r?\n/).map(l=>l.split('|'));
function q(t,id){return levels[t].find(r=>r[0]===id);}
function swap(t,a,u,b){const x=q(t,a).slice(1),y=q(u,b).slice(1);q(t,a).splice(1,6,...y);q(u,b).splice(1,6,...x);}
swap('easy','067','medium','135');
swap('medium','080','hard','172');
q('easy','037')[3]='أي رابر اشتهر بأغنية «لوز يورسِلف»؟';q('easy','037')[4]='Which rapper is known for Lose Yourself?';
q('easy','042')[3]='من الدي جي صاحب أغنية «تيتانيوم»؟';q('easy','042')[4]='Which DJ released Titanium?';
q('medium','122').splice(1,6,'song:livinvidaloca:originalalbumyear','rickyalbum','في أي سنة صدر ألبوم ريكي مارتن الإنجليزي الأول الذي يضم «ليفين لا فيدا لوكا»؟',"In which year was Ricky Martin's first English-language album containing Livin' La Vida Loca released?",'1999','1999');
const keys={
'069':'song:bohemian:album','070':'song:dancingqueen:album','071':'album:thriller:producer','072':'song:cometogether:album','073':'song:rollingdeep:album','074':'song:shapeofyou:album','075':'song:iwillalways:originalwriter','076':'song:myheart:film','077':'song:clocks:album','078':'song:withwithout:album','079':'song:yoursong:lyricist',
'137':'album:nightopera:coproducer','138':'song:dancingqueen:workingtitle','139':'song:thriller:writer','140':'song:cometogether:studio','141':'song:rollingdeep:cowriter','142':'song:shapeofyou:coproducer','143':'song:iwillalways:producer','144':'song:myheart:lyricist','145':'song:clocks:coproducer','146':'album:joshuatree:producers','147':'album:eltonjohn:orchestralarranger','148':'album:heroes:coproducer'};
for(const [t,rows]of Object.entries(levels)){for(const r of rows){if(keys[r[0]])r[1]=keys[r[0]];r[4]=r[4]?.replaceAll('Hips Dont Lie',"Hips Don't Lie");}fs.writeFileSync(`${d}/${t}.psv`,rows.map(r=>r.join('|')).join('\n')+'\n');}
for(const f of ['lib/data/question_bank.dart','lib/data/playable_category_registry.dart']){
let s=fs.readFileSync(f,'utf8');if(!s.includes("import 'questions/international_music_final.dart';"))s=s.replace("import 'questions/arabic_music_final.dart';","import 'questions/arabic_music_final.dart';\nimport 'questions/international_music_final.dart';");
if(f.includes('question_bank'))s=s.replace("  'arabic_music': arabic_musicFinalQuestions,","  'arabic_music': arabic_musicFinalQuestions,\n  'international_music': international_musicFinalQuestions,");
else s=s.replace("  PlayableCategory('arabic_music', '🎼', 'أغاني عربية', 'Arabic Music', arabic_musicFinalQuestions),","  PlayableCategory('arabic_music', '🎼', 'أغاني عربية', 'Arabic Music', arabic_musicFinalQuestions),\n  PlayableCategory('international_music', '🌎', 'أغاني أجنبية', 'International Music', international_musicFinalQuestions),");
fs.writeFileSync(f,s);
}
