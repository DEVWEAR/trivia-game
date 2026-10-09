const fs=require('node:fs'),path=require('node:path');
const m=JSON.parse(fs.readFileSync(path.resolve(__dirname,'../content/two_pics_redesign.json'),'utf8'));
const words=s=>new Set(s.toLowerCase().replace(/[^a-z ]/g,' ').split(/\s+/).filter(w=>w&&!['the','of','to','a','in','under','with','by'].includes(w)));
const candidates=[];const keys=new Set();let duplicateConcepts=0;
for(const c of m.cards){const key=c.factKey||c.answerEn.toLowerCase();if(keys.has(key))duplicateConcepts++;keys.add(key);}
for(let a=0;a<m.cards.length;a++)for(let b=a+1;b<m.cards.length;b++){
 const x=words(m.cards[a].answerEn),y=words(m.cards[b].answerEn),n=[...x].filter(w=>y.has(w)).length;
 const score=n/new Set([...x,...y]).size;
 if(score>=.5)candidates.push({a:m.cards[a].id,b:m.cards[b].id,score});
}
const reviewed=m.semanticOverlapReview?.status==='PASS'&&m.semanticOverlapReview.unresolved===0;
const errors=duplicateConcepts+candidates.length+(reviewed?0:1);
console.log(JSON.stringify({status:errors?'FAIL':'PASS',comparedCards:m.cards.length,duplicateConcepts,nearAnswerCandidates:candidates,unresolvedSemanticOverlaps:m.semanticOverlapReview?.unresolved??null,method:'Normalized concept uniqueness and token-similarity candidate scan, supplemented by recorded editorial comparison of all 102 concepts. A token scan alone cannot prove semantic uniqueness.'},null,2));
if(errors)process.exitCode=1;
