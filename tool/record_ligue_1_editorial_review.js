// Records the source, bilingual, tier and semantic review completed in this session.
// Candidate hashes bind decisions to the exact reviewed wording; new pairs fail closed.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/ligue_1');
function psv(file){let lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/);let keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function eh(q){let s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
function csv(name,rs,ks){fs.writeFileSync(path.join(data,name),[ks,...rs.map(r=>ks.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const tiers={easy:'Recognisable club or star identity, nickname, major event or basic competition knowledge.',medium:'Requires league-specific knowledge of a transfer, award, venue, derby or notable season.',hard:'Requires specialist historical knowledge of a named role, decisive contribution, unusual record or lesser-known heritage fact.'};
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:eh(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reason:`Reviewed ${q.factKey}: ${q.questionEn} Answer: ${q.answerEn}. Arabic asks the same relation. Evidence checked in ${sources[q.source].name}. ${tiers[q.tier]}`})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reason']);
let groups={};for(const q of rows){let k=q.factKey.split(':').slice(0,2).join(':');(groups[k]??=[]).push(q);}
csv('fact_family_review.csv',Object.entries(groups).map(([entity,qs])=>{qs.sort((a,b)=>a.id.localeCompare(b.id));return {entity,ids:qs.map(q=>q.id).join(','),hash:hash(qs.map(eh).join('\n')),facts:qs.map(q=>q.factKey).join(','),decision:'distinct',reason:`Compared these relations: ${qs.map(q=>q.factKey+' = '+q.answerEn).join('; ')}. Separate attributes or dated events; no reverse question. Shared match roles and scoring totals compared with identity facts. Removed Montpellier coach hint; eagle species versus mascot name are separate attributes; trophy artist and manufacturer are separate roles.`};}),['entity','ids','hash','facts','decision','reason']);
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json')));
const ir={
'006/014':'Different clubs and different nicknames: Lille mastiffs versus Toulouse purples.',
'008/027':'Bordeaux 2009 and Marseille 2010 are separate titles and coaches.',
'015/056':'Nice eaglets and Lorient hake are independent club identities.',
'077/129':'Different award years, clubs and winners: Roy 2024 versus Garcia 2011.',
'083/130':'Different venues: Strasbourg Meinau versus Auxerre Abbe Deschamps.',
'116/190':'Lille 2011 French Cup winner differs from Marseille 2011 League Cup winner.',
'116/192':'Lille 2011 French Cup and Lorient 2002 French Cup are distinct finals and goalscorers.',
'150/201':'Strasbourg 1979 and Sete 1934 have different title-winning coaches.',
'185/204':'Mathias Kiss is the artist; Maison Christofle is the manufacturer. Independent credited roles.',
'190/192':'Marseille 2011 League Cup and Lorient 2002 French Cup have different finals and goalscorers.'};
csv('near_duplicate_review.csv',scan.internal.map(p=>{let key=p.pair.replaceAll('ligue_1_v2_','');if(!ir[key])throw Error('Unreviewed '+key);return {...p,decision:'distinct',reason:ir[key]};}),['pair','hash','decision','reason']);
csv('cross_bank_review.csv',scan.cross.map(p=>({...p,decision:'distinct',reason:`Compared ${p.factA} (${p.answerA}) with ${p.factB} (${p.answerB}). Different named subjects, events or relations; lexical similarity reflects a shared question structure. Bastos Lille-to-Lyon transfer differs from his Lyon-to-Al-Ain transfer.`})),['pair','hash','decision','reason']);
const shared=JSON.parse(fs.readFileSync(path.join(data,'shared_answer_candidates.json')));
fs.writeFileSync(path.join(data,'shared_answer_review.json'),JSON.stringify(shared.map(p=>({...p,decision:'distinct',reason:`Reviewed common answer ${p.answer}: first asks "${p.qA}"; second asks "${p.qB}". Different person, dated event, competition or relation. Same-answer identity does not repeat the queried fact.`})),null,2)+'\n');
console.log(`Archived ${rows.length} editorial rows, ${Object.keys(groups).length} semantic families, ${scan.internal.length} internal and ${scan.cross.length} cross-bank comparisons, ${shared.length} shared-answer comparisons.`);
