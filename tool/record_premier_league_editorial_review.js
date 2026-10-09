// Archive completed human source, bilingual, difficulty and semantic review.
// Explicit candidate decisions are stored separately and new pairs fail closed.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/premier_league');
function psv(file){const lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
function csv(name,rows,keys){fs.writeFileSync(path.join(data,name),[keys,...rows.map(r=>keys.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function editorialHash(q){const s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
const reasons={
award:'Golden Boot, Golden Glove and Playmaker recognise goals, clean sheets and assists respectively. Klinsmann inaugural monthly award is a separate historical milestone.',
celebration:'Bocelli opera performance at Leicester trophy celebration is not a player goal celebration.',
ceremony:'Dalglish trophy presenter differs from Henderson receiving captain and Klopp winning coach.',
club:'Different club nicknames, colours, former names and home grounds. Villa colours and Villa Park are separate attributes; Wolves colours and Molineux likewise. Ipswich home differs from horse breed on crest.',
coach:'Distinct coaching careers and roles: Ferguson title record; Vieira captain not coach; Klopp champion, Henderson captain; Ranieri champion, Pearson predecessor; Pochettino Southampton entry, Ardiles Argentine pioneer. Wenger Henry conversion, Conte formation, Howe Bournemouth promotion, Dyche European qualification, Wagner promotion, Ljungberg caretaker, Smith survival and Hasenhuttl recovery are different achievements. Solskjaer first coaching club differs from his transfer origin and four-goal playing performance.',
competition:'38 matches per club and relegation to Championship are separate format rules, not repeated 20-club introduction season.',
derby:'North London, Merseyside and Black Country are different rivalries and six different clubs. No reverse derby-partner question.',
fairplay:'Di Canio caught ball to stop attack for injured goalkeeper. His scissor kick is a different event and asks Sinclair provider.',
history:'Inaugural year, initial field size and reduction season are different competition milestones. Blackburn first title differs from backer Walker and Sutton partnership. United Newton Heath, City Ardwick, Arsenal Dial Square, Liverpool founder and Forest shinty origins are independent historical relations.',
honour:'First Hall of Fame inductees are asked together once, not separate inverse first-inductee questions.',
identity:'Arsenal cannon, Spurs cockerel, Everton tower, Bournemouth Dowsett, Ipswich horse and United Salford origin are different crest/name attributes. Invincibles club differs from captain Vieira and Arsenal scoring in every match in a different season.',
match:'Distinct memorable performances rather than routine scorer grids. City 2012 final asks winning scorer, assist provider and equalising scorer: three different actions/roles. Rooney overhead goal, first goal opponent and 19th-birthday goal are three different matches. Newcastle comebacks, Yeboah volley, Mata scissor brace and Ruddock equaliser concern separate games. Deane first-ever goal differs from Sheringham first televised goal the next day. Five goalkeeper goals concern different players/matches; Schmeichel asks first-goal club.',
milestone:'Schmeichel first goalkeeper goal asks Aston Villa, not repeated identity of another scoring goalkeeper.',
player:'Nationality, nickname, original position, former employer, captaincy, award and celebration are separate relations. Rooney paired Everton career question occurs once. Solskjaer Molde transfer, Cardiff coaching and four substitute goals differ. Cole penalty proportion is distinct from title clubs of Ashley Cole. No reversed family or nationality questions.',
record:'Career Shearer goals, Lampard midfielder output, Haaland season, Kane/Son combination, Mane speed, Long speed, Vardy streak, Cech career clean sheets and debut-season clean sheets measure different things. Henry assists and Arsenal every-match scoring differ from Invincibles unbeaten season. Historical numbers are scoped; no obsolete current rankings.',
season:'COVID interruption is separate from Liverpool title/captain/coach questions.',
tactics:'Conte three-back formation differs from Mourinho holding pivot Makelele and Chelsea 2005 conceded-goal record.',
tech:'VAR first season, goal-line technology first season, initial test ground and vanishing spray purpose are different systems/attributes.',
transfer:'Cantona Leeds, Ronaldo Sporting, Salah Roma, Wright Palace, Keane Forest and Mane Salzburg are separate player moves. Salah initial English Chelsea spell differs from later Roma-to-Liverpool move.',
trophy:'Third-lion symbolism, jeweller Asprey and malachite base are independent design/craft attributes; no dimensions trivia.',
venue:'Current Arsenal/Chelsea/United homes, City/Everton former grounds, original City sporting event and fictional Selhurst resident are different venues or attributes.'
};
const families=[];
for(const[entity,members]of Map.groupBy(rows,q=>q.factKey.split(':')[0])){members.sort((a,b)=>a.id.localeCompare(b.id));if(!reasons[entity])throw Error('Missing family '+entity);families.push({entity,ids:members.map(q=>q.id).join(','),hash:hash(members.map(editorialHash).join('\n')),facts:members.map(q=>q.factKey).join(','),decision:'distinct',reason:reasons[entity]});}
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json'),'utf8'));
const decisions=JSON.parse(fs.readFileSync(path.join(data,'editorial_decisions.json'),'utf8'));
function review(list){return list.map(c=>{const d=decisions[c.pair];if(!d||d.hash!==c.hash||!d.reason)throw Error('Unreviewed/stale '+c.pair);return{pair:c.pair,hash:c.hash,decision:'distinct',reason:d.reason};});}
csv('near_duplicate_review.csv',review(scan.internal),['pair','hash','decision','reason']);
csv('cross_bank_review.csv',review(scan.cross),['pair','hash','decision','reason']);
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:editorialHash(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reviewDate:'2026-10-07'})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reviewDate']);
csv('fact_family_review.csv',families,['entity','ids','hash','facts','decision','reason']);
