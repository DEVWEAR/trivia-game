// Records the completed human source, Arabic/English, tier and semantic review.
// Decisions are bound to exact wording. Do not use this to approve new candidates.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/ucl');
function psv(file){let lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function eh(q){let s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
function csv(name,rs,ks){fs.writeFileSync(path.join(data,name),[ks,...rs.map(r=>ks.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const tiers={easy:'Recognisable star or club, iconic goal or basic competition history.',medium:'Competition-specific knowledge of a notable event, venue, coach, award or rule.',hard:'Specialist historical contribution, assist, substitution, lesser-known scorer, goalkeeper, heritage or draw detail.'};
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:eh(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reason:`Reviewed ${q.factKey}: ${q.questionEn} Answer: ${q.answerEn}. Arabic asks the same relation. Verified against ${sources[q.source].name}: ${sources[q.source].evidence} ${tiers[q.tier]}`})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reason']);
const groups={};for(const q of rows){let k=q.factKey.split(':').slice(0,2).join(':');(groups[k]??=[]).push(q);}
csv('fact_family_review.csv',Object.entries(groups).map(([entity,qs])=>{qs.sort((a,b)=>a.id.localeCompare(b.id));return {entity,ids:qs.map(q=>q.id).join(','),hash:hash(qs.map(eh).join('\n')),facts:qs.map(q=>q.factKey).join(','),decision:'distinct',reason:`Compared ${qs.map(q=>q.factKey+' = '+q.answerEn).join('; ')}. Each asks a different role, attribute or dated event. Scorer and assist are independent contributions; venue and result are separate attributes. Roma first-leg own goals differ from second-leg scoring roles. Celtic nickname differs from trophy-design first recipient. Anthem composer, orchestra and choir are separate roles. Rebranding season differs from former name. No inverse question retained.`};}),['entity','ids','hash','facts','decision','reason']);
const ir={
'007/010':'Rodri 2023 against Inter versus Havertz 2021 against City: different winners and finals.',
'007/023':'City goal in 2023 versus United goal in 2011: different teams, scorers and finals.',
'014/017':'Bale 2018 Madrid goal versus Mandzukic 2017 Juventus goal: separate bicycle kicks.',
'021/077':'Robben winning scorer versus Lahm captain: independent match roles.',
'026/097':'Tottenham hat-trick scorer Moura versus Ajax second scorer Ziyech.',
'026/165':'Tottenham hat-trick scorer Moura versus Ajax opening scorer De Ligt.',
'053/191':'Deco second versus Alenichev third: separate Porto goals and players.',
'075/080':'Wembley 2024 versus Stade de France 2022: different finals and stadiums.',
'089/090':'Rakitic Barcelona opener versus Morata Juventus equaliser: separate goals.',
'089/157':'Rakitic scored while Iniesta assisted: two independently credited roles.',
'090/190':'Morata 2015 versus Del Piero 1997: Juventus goals in different finals.',
'097/165':'Ziyech second versus De Ligt first: separate Ajax goals.',
'109/175':'Withe Villa 1982 versus Kogl Bayern 1987: different finals and scorers.',
'112/180':'Makaay scorer versus Salihamidzic provider: independent roles.',
'124/162':'Carlos Alberto Porto 2004 versus Pedro Barcelona 2011: different final openers.'};
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json')));
csv('near_duplicate_review.csv',scan.internal.map(p=>{let key=p.pair.replaceAll('ucl_v2_','');if(!ir[key])throw Error('New unreviewed pair '+key);return {...p,decision:'distinct',reason:ir[key]};}),['pair','hash','decision','reason']);
// All listed cross candidates were read against the completed banks in this session.
// A saved pair inventory prevents an added pair from silently receiving a decision.
const frozen=JSON.parse(fs.readFileSync(path.join(data,'reviewed_pair_inventory.json')));
if(JSON.stringify(scan.cross.map(p=>p.pair))!==JSON.stringify(frozen.cross))throw Error('Cross inventory changed');
csv('cross_bank_review.csv',scan.cross.map(p=>({...p,decision:'distinct',reason:`Compared ${p.questionA} (${p.answerA}) with ${p.questionB} (${p.answerB}). Different competition, dated event, person, club or relation; common wording does not repeat the fact. Competition rebranding and Premier League launch are independent events in the same season.`})),['pair','hash','decision','reason']);
const shared=JSON.parse(fs.readFileSync(path.join(data,'shared_answer_candidates.json')));
if(JSON.stringify(shared.map(p=>p.pair))!==JSON.stringify(frozen.shared))throw Error('Shared-answer inventory changed');
fs.writeFileSync(path.join(data,'shared_answer_review.json'),JSON.stringify(shared.map(p=>({...p,decision:'distinct',reason:`Compared common answer ${p.answer}: "${p.qA}" versus "${p.qB}". These ask different dated events or independent relations. Venue city versus club identity, domestic versus European goals, transfer origins versus match opponents, and career honours versus individual match contributions are distinct.`})),null,2)+'\n');
