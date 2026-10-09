const fs=require('node:fs'),path=require('node:path');
const file=path.resolve(__dirname,'../content/two_pics_redesign.json'),m=JSON.parse(fs.readFileSync(file,'utf8'));
function flag(n,reason){const c=m.cards.find(c=>c.id==='two_pics_'+String(n).padStart(3,'0'));c.flag=reason;c.semanticStatus='REVIEW_REQUIRED';c.difficultyVerified=false;}
// Final pair review must override provisional approvals. Attractive artwork
// cannot repair overlapping answers, language asymmetry or an easy hard card.
flag(34,'Underlying-answer overlap: house key and door key (024) describe essentially the same object. No answer change made.');
flag(38,'Bilingual deduction remains uncertain: tongue + sea naturally gives the Arabic coastal term, but does not reliably lead an English player to coastal spit.');
flag(50,'Language asymmetry: head + money spells Arabic رأس المال, but the head component does not clearly contribute to English Capital.');
flag(74,'Fish memory is not a precise standard bilingual phrase; avoid implying the unsupported three-second goldfish-memory myth.');
flag(99,'Arabic قمة الجليد does not precisely name the English idiom Tip of the iceberg. Needs an explicit minimal bilingual correction before final approval.');
flag(101,'The laptop error clue alone can suggest the full Arabic answer خلل برمجي. Insect wordplay contributes more clearly in English than Arabic.');
for(const n of [72,73,75,80,86,88,89,90,91,94,95,97,100,102]){
 const c=m.cards.find(c=>c.id==='two_pics_'+String(n).padStart(3,'0'));
 if(!c.flag)flag(n,'600-point difficulty not confidently supported: this literal two-component pair is too direct or familiar. Preserving the existing answer and points; no artificial visual obscurity added.');
}
m.status='IN_PROGRESS_PUBLICATION_BLOCKED';
m.auditMethod='Every generated output inspected by assistant vision. Programmatic audit checks review coverage, new unique hashes, source-row preservation and packaged assets; it is not an independent image-recognition score. Final editorial flags override provisional pair approvals.';
fs.writeFileSync(file,JSON.stringify(m,null,2)+'\n');
console.log('Final editorial review unresolved cards: '+m.cards.filter(c=>c.flag).map(c=>c.id).join(', '));
