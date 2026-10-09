const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto');
const root=path.resolve(__dirname,'..');
const manifest=JSON.parse(fs.readFileSync(path.join(root,'content/two_pics_redesign.json'),'utf8'));
const errors=[];const hashes=new Set(),ids=new Set();let reviewed=0;
const cardIds=new Set(),arAnswers=new Set(),enAnswers=new Set();
let duplicateIds=0,duplicateArabicAnswers=0,duplicateEnglishAnswers=0,missingTranslations=0;
const norm=s=>s.normalize('NFKC').toLowerCase().replace(/[\u064b-\u065f\u0670]/g,'').replace(/[^\p{L}\p{N}]+/gu,' ').trim();
const sha=b=>crypto.createHash('sha256').update(b).digest('hex');
const texts=['001_034','035_068','069_102'].map(s=>fs.readFileSync(path.join(root,'lib/data/questions/two_pics_questions_'+s+'.dart'),'utf8')).join('\n');
if(manifest.cards.length!==102)errors.push('Card count must be 102');
for(const p of [200,400,600])if(manifest.cards.filter(c=>c.points===p).length!==34)errors.push('Must have 34 Two Pics cards at '+p);
for(const s of ['001_034','035_068','069_102'])if(!fs.readFileSync(path.join(root,'lib/data/questions/two_pics_questions_'+s+'.dart'),'utf8').includes("String localPhoto(int side)=>'assets/two_pics/redesign/"))errors.push(s+': runtime still uses old images');
for(const card of manifest.cards){
 if(cardIds.has(card.id)){duplicateIds++;errors.push(card.id+': duplicate card ID');}cardIds.add(card.id);
 if(!card.answerAr?.trim()||!card.answerEn?.trim()){missingTranslations++;errors.push(card.id+': missing bilingual answer');}
 const ar=norm(card.answerAr||''),en=norm(card.answerEn||'');
 if(arAnswers.has(ar)){duplicateArabicAnswers++;errors.push(card.id+': duplicate Arabic answer');}arAnswers.add(ar);
 if(enAnswers.has(en)){duplicateEnglishAnswers++;errors.push(card.id+': duplicate English answer');}enAnswers.add(en);
 if(card.replacementRevision&&(!card.editorialReview||card.editorialReview.status!=='PASS'||!card.factKey))errors.push(card.id+': replacement missing editorial evidence');
 const expected=card.answerCorrection?.currentRow||card.originalRow;
 if(!texts.includes(expected))errors.push(card.id+': question/answer row differs from documented original or approved correction');
 if(card.answerCorrection&&!card.answerCorrection.authorized)errors.push(card.id+': answer correction lacks authorization');
 if(card.flag||card.semanticStatus!=='PASS')errors.push(card.id+': unresolved pair semantics');
 if(card.images.length!==2)errors.push(card.id+': must have two new images');
 for(const im of card.images){
  if(ids.has(im.id))errors.push(im.id+': duplicate image ID');ids.add(im.id);
  const filename=path.join(root,im.path);
  if(!fs.existsSync(filename)){errors.push(im.id+': missing redesigned image');continue;}
  const bytes=fs.readFileSync(filename),digest=sha(bytes);
  if(bytes.subarray(0,8).toString('hex')!=='89504e470d0a1a0a'||bytes.readUInt32BE(16)!==im.width||bytes.readUInt32BE(20)!==im.height||im.width<1024||Math.abs(im.width/im.height-4/3)>.02)errors.push(im.id+': invalid size, format or aspect ratio');
  if(digest!==im.sha256||hashes.has(digest)||manifest.previousImageHashes.includes(digest))errors.push(im.id+': stale, duplicate or unverified image');hashes.add(digest);
  if(im.review!=='PASS'||!im.observedMeaning||im.fullAnswerAlone!==false||im.distortionFree!==true||im.styleMatch!==true)errors.push(im.id+': incomplete visual semantic review');else reviewed++;
  if(process.argv.includes('--build')&&(!fs.existsSync(path.join(root,'build/web/assets',im.path))||sha(fs.readFileSync(path.join(root,'build/web/assets',im.path)))!==digest))errors.push(im.id+': bundled redesign mismatch');
 }
 if(!card.bothImagesNecessary||!card.bilingualConnectionVerified||!card.difficultyVerified||!card.combinationExplanation)errors.push(card.id+': incomplete pair-level editorial audit');
}
if(manifest.status!=='COMPLETE')errors.push('Redesign is not COMPLETE; publication blocked');
if(process.argv.includes('--build')){
 const dir=path.join(root,'build/web/assets');
 const visit=d=>{if(!fs.existsSync(d))return;for(const e of fs.readdirSync(d,{withFileTypes:true})){const f=path.join(d,e.name);if(e.isDirectory())visit(f);else if(/\.(png|jpg|jpeg)$/i.test(f)&&manifest.previousImageHashes.includes(sha(fs.readFileSync(f))))errors.push('Old clue image still bundled: '+path.relative(dir,f));}};
 visit(dir);
}
console.log(JSON.stringify({status:errors.length?'BLOCKED':'PASS',cards:manifest.cards.length,easy200:manifest.cards.filter(c=>c.points===200).length,medium400:manifest.cards.filter(c=>c.points===400).length,hard600:manifest.cards.filter(c=>c.points===600).length,images:ids.size,reviewed,duplicateIds,duplicateArabicAnswers,duplicateEnglishAnswers,missingTranslations,issues:errors.length,unresolvedAnswers:manifest.cards.filter(c=>c.flag).map(c=>({id:c.id,reason:c.flag}))},null,2));
if(errors.length){console.error(errors.slice(0,12).join('\n'));process.exitCode=1;}
