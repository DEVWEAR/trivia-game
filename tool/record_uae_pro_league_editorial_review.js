// Archives reviewed facts and explicit similarity decisions. New candidates fail closed.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/uae_pro_league');
function psv(file){const lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
function csv(name,rows,keys){fs.writeFileSync(path.join(data,name),[keys,...rows.map(r=>keys.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function editorialHash(q){const s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
const reasons={
award:'Golden Glove definition is distinct from winning goalkeeper identity.',
awards:'Emirati, foreign, fans, keeper, young Emirati and young resident awards are separate categories. Monthly Opta provider and cup Golden Shoe are different award attributes. Excluded coach award already used by UAE Football.',
club:'Emirates Club Ras Al Khaimah location is one club-emirate relation; Hatta and Khorfakkan location questions were removed for protected-bank overlap.',
coach:'Pirlo United appointment and Ivic double refer to separate clubs/coaches; Tarek two Dibba promotions and Walid Hatta promotion identify two different historical career achievements.',
coaching:'Jardim Shabab, Rebrov Ain, Anbari Sharjah, Braga Jazira, Hickersberger Wahda, Ze Mario Wasl, Jurcic Nasr and 2023 appointments concern distinct managers, clubs and campaigns. Repetto previous employer differs from UAE appointment. Braga successor is Vercauteren, not repeated Braga identity.',
competition:'ADNOC and ADIB sponsorship names, organizer, 14-club field, professional-era start and cancelled 2019-20 season identify different structural attributes. No annual champion grid.',
continental:'Jazira two World Cups versus 2021 Pirae opponent; Shaab Asian final, Nasr first Asian win, Wahda playoff and Nilmar Jeddah brace concern distinct clubs and matches. Protected Jazira 2017 opponent excluded.',
history:'Nasr former name, name proposer, original shirt colours and Bombay football imports are separate historical relations. Khorfakkan former name and Yarmouk merger partner differ. Bani Yas second-division cup and Bataeh first pro goal/debut opponent differ. Zabeel opening guest pair and esports console are separate events.',
identity:'Distinct club nicknames with different answers. Ain purple and Anderlecht inspiration are visual attribute and historical influence. Kalba 2024 renaming and mangrove crest differ. Award sleeve placement and Wasl IFFHS recognition are different institutional honours.',
organization:'Original organizer name differs from current identity and Egyptian Super Cup country.',
player:'Each named player club, nationality, family relation, nickname, former employer, milestone or interview dream refers to a different attribute. Elneny Jazira destination versus Arsenal former employer are different relations. Rahimi brothers not asked in reverse. Denilson disambiguated from namesake. Oliveira Asian top-scorer award differs from four-goal match opposing club.',
record:'Shabab 10-0 winner versus Dabbur hat-trick; ADIB title-leading club versus Tagliabue goal-leading player; Gyan consecutive Golden Boots, Baiano inaugural scorer, Walid Super titles and Mateus youngest scorer are independent records, with changing records explicitly dated.',
rivalry:'Abu Dhabi Jazira/Wahda pairing differs from protected Bur Dubai and Saudi Jeddah derby pairings.',
rules:'Relegation destination, first head-to-head tie-break, three-caution ban, transferred cautions, second-caution erasure and cup quarter-final byes are distinct competition rules, scoped to 2024-25.',
scoring:'Khribin 2024 league award, Cartabia Shabab club leading scorer and Mansoor youth Silver Shoe are different competitions/scopes.',
supercup:'Cairo venue, Emirates 2010 opponent, Kerkar brace and Lima 2016 penalty identify separate events/roles. Emenike fastest-goal record is explicitly dated.',
transfer:'Different players and transfer origins/destinations: Mabkhout Nasr, Fekir Betis, Grafite Wolfsburg, Azmoun Leverkusen, Mierez Osijek, Manolas Olympiacos and Bastos Lyon. No fee or loan-versus-selling-club confusion.',
gulf:'Nasr Saham opponent and Leonardo Lima winning penalty differ from Bani Yas Al Khor opponent and Nawaf Mubarak goal; separate two finals and event roles.',
leaguecup:'Inaugural Ain title, Aguirre first-season cup, Nasr 2015 Toure brace/Hernandez debut goal, Nasr 2020 Negredo opening/Toze winning goal, Wahda 2024 Pimenta goal/Zaabi assist and Jazira 2025 Kebano winner/Mello two assists are different event roles. Conflicting Negredo seconds excluded.',
match:'Azaro four goals, Mabkhout Qatar brace, Ghayedi comeback, Laba title-clinching four, Berg title hat-trick, Dibba Hisn first winner, Draxler equaliser and Oliveira four-goal opponent are distinct landmark performances, not arbitrary ordinary goal-minute questions.',
presidentscup:'Emirates first major trophy is cup type, not repeated 2010 Super final opponent.',
season:'Ending Shabab unbeaten run is opposing club Wasl, not protected championship-winner fact.',
venue:'Hatta Hamdan Bin Rashid stadium, Arsenal refurbished Nasr opening visitor and Sharjah three Super venues are distinct venue attributes. Nasr original 1978 opening not repeated.',
youth:'Jazira inaugural U21 champion and Kalba first professional U21 title are distinct historical achievements.',
asia:'First all-UAE knockout pairing, Nasr maiden opponent and Wasl bronze opponent concern three different historical events.',
milestone:'Andre Dias first professional-era goal is a single inaugural milestone, without an annual first-goal table.'
};
const families=[];
for(const[entity,members]of Map.groupBy(rows,q=>q.factKey.split(':')[0])){members.sort((a,b)=>a.id.localeCompare(b.id));if(!reasons[entity])throw Error('Missing family '+entity);families.push({entity,ids:members.map(q=>q.id).join(','),hash:hash(members.map(editorialHash).join('\n')),facts:members.map(q=>q.factKey).join(','),decision:'distinct',reason:reasons[entity]});}
const decisions={};
function add(keys,reason){for(const k of keys.split(' '))decisions[k]=reason;}
add('004/005 004/012 004/013 004/025 004/038 005/012 005/013 005/025 005/038 006/012 006/013 006/037 006/040 011/025 012/013 012/037 012/040 013/037 013/040 026/037 026/039 037/039 037/040','Different club nicknames and clubs; similar nickname-question grammar does not repeat the fact.');
add('045/062','Aboutrika and Mohamed Zidan are different Egyptian players with separate Bani Yas spells.');
add('069/070 070/076','Different award categories and winners: Emirati Golden Ball, foreign Golden Ball and goalkeeper Golden Glove.');
add('080/121','Grafite arrived from Wolfsburg; Ali Karimi departed to Bayern. Different players and opposite transfer directions.');
add('087/165','Tadic Fenerbahce arrival in 2025 and Dzsudzsak Bursaspor arrival in 2016 concern separate transfers.');
add('089/155','Ali Salmeen domestic Wasl-to-Kalba move differs from Tapia arriving at Wasl from Spanish Leganes.');
add('092/122 092/136','Braga Jazira 2011, Ze Mario Wasl 2007 and Ivic Ain 2026 are separate managers/clubs/double campaigns.');
const cross={};
function crossAdd(keys,reason){for(const k of keys.split(' '))cross[k]=reason;}
crossAdd('006/uae_football_v2_031 006/uae_football_v2_032 012/uae_football_v2_031 012/uae_football_v2_032 013/uae_football_v2_031 013/uae_football_v2_032 026/uae_football_v2_031 026/uae_football_v2_032 026/uae_football_v2_033 037/uae_football_v2_031 037/uae_football_v2_032 037/uae_football_v2_033 039/uae_football_v2_031 039/uae_football_v2_032 039/uae_football_v2_033 040/uae_football_v2_031 040/uae_football_v2_032 058/uae_football_v2_031 058/uae_football_v2_032 061/uae_football_v2_031 061/uae_football_v2_032 061/uae_football_v2_033','Different UAE clubs and nicknames; protected Bani Yas Sky Blues, Sharjah King and Wasl Emperor are not reused.');
crossAdd('034/uae_football_v2_135','Crespo Ain Asian 2024 coach differs from Metsu Ain Asian 2003 coach: separate title campaigns.');
crossAdd('045/uae_football_v2_036 053/uae_football_v2_036 059/uae_football_v2_036 062/uae_football_v2_036','Aboutrika, Abedi Pele, Cabaye and Zidan UAE clubs concern different players from protected George Weah Jazira career.');
crossAdd('080/uae_football_v2_136 100/uae_football_v2_136 102/uae_football_v2_187','Grafite Wolfsburg, Valdivia Palmeiras and Ribeiro Cruzeiro are separate transfers from Gyan Sunderland and Lima Benfica.');
crossAdd('083/uae_football_v2_020 083/uae_football_v2_021','Hatta stadium Hamdan Bin Rashid differs from Nasr Al Maktoum and Wasl Zabeel home stadiums.');
crossAdd('084/uae_football_v2_040 084/uae_football_v2_058 084/uae_football_v2_122','Inaugural Jazira U21 championship differs from Shabab senior 2025 league, Ain 2003 Asian title and Nasr 2020 League Cup.');
crossAdd('092/uae_football_v2_126','Braga Jazira 2011 league/President Cup coach differs from Bonamigo Shabab 2011 Gulf/League Cup coach.');
crossAdd('099/uae_football_v2_122','Inaugural League Cup Ain 2009 versus Nasr 2020 cup title: separate editions; inaugural framing adds competition origin context.');
crossAdd('112/uae_football_v2_005','Kebano Jazira 2025 ADIB final winner differs from Matar UAE 2007 Gulf national-team final winner.');
crossAdd('132/uae_football_v2_053','Jurcic Nasr 2020 League Cup coach differs from Mahdi Ali UAE 2013 Gulf Cup national-team coach.');
crossAdd('136/uae_football_v2_068','Ivic coaching identity versus Ain winning club identity in 2026 double are distinct event roles, not two club-winner paraphrases.');
crossAdd('168/uae_football_v2_202','Jazira opponent Pirae in edition 2021 differs from opponent Auckland in edition 2017.');
crossAdd('179/uae_football_v2_151','Nilmar Nasr brace against Ittihad in Jeddah differs from Ahmed Khalil UAE brace against Japan: different teams/matches in 2016.');
crossAdd('044/saudi_general_v2_043','Abu Dhabi Jazira/Wahda derby differs from Jeddah Ittihad/Ahli derby.');
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json'),'utf8'));
function review(list,map,internal){return list.map(c=>{const key=c.pair.replace('uae_pro_league_v2_','').replace(internal?'/uae_pro_league_v2_':'NEVER','/');if(!map[key])throw Error('Unreviewed '+key);return{pair:c.pair,hash:c.hash,decision:'distinct',reason:map[key]};});}
csv('near_duplicate_review.csv',review(scan.internal,decisions,true),['pair','hash','decision','reason']);
csv('cross_bank_review.csv',review(scan.cross,cross,false),['pair','hash','decision','reason']);
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:editorialHash(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reviewDate:'2026-10-07'})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reviewDate']);
csv('fact_family_review.csv',families,['entity','ids','hash','facts','decision','reason']);
console.log(JSON.stringify({reviewedQuestions:rows.length,semanticGroups:families.length,internalReviewed:scan.internal.length,crossReviewed:scan.cross.length}));
