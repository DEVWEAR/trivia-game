const fs = require('fs'), path = require('path'), crypto = require('crypto');
const root = path.resolve(__dirname, '..');
const category = process.argv[2] || 'emirati_music';
function norm(s) {return s.toLowerCase().replace(/[\u064B-\u065F\u0670\u0640]/g,'').replace(/[أإآ]/g,'ا').replace(/[^\p{L}\p{N}]+/gu,' ').trim();}
function read(cat) {return ['easy','medium','hard'].flatMap(tier=>{
 const lines=fs.readFileSync(path.join(root,'content',cat,tier+'.psv'),'utf8').trim().split(/\r?\n/); const keys=lines.shift().replace(/^\uFEFF/,'').split('|');
 return lines.filter(Boolean).map(line=>{const r=Object.fromEntries(line.split('|').map((v,i)=>[keys[i],v]));r.id=cat+'_v2_'+r.id;r.en=new Set(norm(r.questionEn).split(' '));r.ar=new Set(norm(r.questionAr).split(' '));return r;});
 });}
function sim(a,b) {let n=0;for(const t of a)if(b.has(t))n++;return n/(a.size+b.size-n);}
function candidate(a,b,en,ar) {return {pair:a.id+'/'+b.id,hash:crypto.createHash('sha256').update(a.questionAr+a.questionEn+a.answerAr+a.answerEn+b.questionAr+b.questionEn+b.answerAr+b.answerEn).digest('hex'),similarity:+en.toFixed(3),arabicSimilarity:+ar.toFixed(3),factA:a.factKey,factB:b.factKey,questionA:a.questionEn,answerA:a.answerEn,questionB:b.questionEn,answerB:b.answerEn};}
const rows=read(category); const internal=[];const cross=[];let max=0;
for(let i=0;i<rows.length;i++)for(let j=i+1;j<rows.length;j++) {
 const a=rows[i],b=rows[j],en=sim(a.en,b.en),ar=sim(a.ar,b.ar);max=Math.max(max,en);
 if(en>=.6||ar>=.6||(a.factKey.split(':').slice(0,2).join(':')===b.factKey.split(':').slice(0,2).join(':')&&norm(a.answerEn)===norm(b.answerEn)))internal.push(candidate(a,b,en,ar));
}
for(const cat of ['uae_football','uae_general','uae_heritage','gulf_culture','kuwait_general','saudi_general','uae_pro_league','premier_league','la_liga','serie_a','bundesliga','ligue_1','ucl','world_cup','football_legends']) { const old=read(cat);for(const a of rows)for(const b of old) {
 const en=sim(a.en,b.en),ar=sim(a.ar,b.ar);
 if(en>=.5||ar>=.5||a.factKey===b.factKey)cross.push(candidate(a,b,en,ar));
}}
if(process.argv.includes('--save'))fs.writeFileSync(path.join(root,'content',category,'similarity_scan.json'),JSON.stringify({internal,cross,maximumEnglishSimilarity:+max.toFixed(3)},null,2)+'\n');
console.log(JSON.stringify({internal,cross,maximumEnglishSimilarity:+max.toFixed(3)},null,2));
