const fs=require('fs'),path=require('path');
const root=path.resolve(__dirname,'..');
function read(cat){return ['easy','medium','hard'].flatMap(t=>fs.readFileSync(path.join(root,'content',cat,t+'.psv'),'utf8').trim().split(/\r?\n/).slice(1).filter(Boolean).map(l=>{let [id,factKey,source,ar,q,aa,a]=l.split('|');return {id:cat+'_v2_'+id,factKey,q,a};}));}
const cats=['uae_football','uae_general','uae_heritage','gulf_culture','kuwait_general','saudi_general','uae_pro_league','premier_league','la_liga','serie_a'];const rows=read('bundesliga');
const norm=s=>s.toLowerCase().replace(/[^\p{L}\p{N}]/gu,'');const pairs=[];
for(const cat of cats)for(const a of rows)for(const b of read(cat))if(norm(a.a)===norm(b.a)&&/[a-z]/i.test(a.a))pairs.push({pair:a.id+'/'+b.id,qA:a.q,qB:b.q,answer:a.a});
if(process.argv.includes('--save'))fs.writeFileSync(path.join(root,'content/bundesliga/shared_answer_candidates.json'),JSON.stringify(pairs,null,2)+'\n');
console.log(JSON.stringify(pairs));

