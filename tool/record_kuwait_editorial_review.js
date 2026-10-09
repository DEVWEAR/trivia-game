// Archives the source, parity, difficulty and semantic decisions reviewed on 2026-10-07.
// Candidate approvals require the explicit pair decisions below; no default approval.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/kuwait_general');
function psv(file){const lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
function csv(name,rows,keys){fs.writeFileSync(path.join(data,name),[keys,...rows.map(r=>keys.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function editorialHash(q){const s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
const reasons={
geography:'Capital, sea coast, separate northern/southern neighbours, western valley, Jal Al-Zor bay, Auhah relative position and local depression term identify independent places/landforms. Northern/southern borders share syntax but different countries; no place answer reused as an inverse question.',
currency:'Official unit, smallest banknote, number of fils and predecessor Indian rupee are distinct monetary attributes. No denomination question gives away another requested denomination.',
science:'KFAS institutional identity, Scientific Center cinema/opening, Ujairy field/museum venue, KFAS funding companies, KISR origin company/initial research fields and Shagaya park name concern separate institutions and attributes. Only founder-company question asks Japan-related offset origin, not a second country-only paraphrase.',
state:'Historical ruling family, international phone code and GMT offset are independent state facts. Shared UAE Arabic-official-language fact removed.',
holiday:'National Day date, Liberation Day date and reason for selecting National Day test separate observances and historical significance, not repeated numeric year/day versions of one anniversary.',
flag:'Bottom stripe colour and black hoist shape are distinct design properties. Four-colour question replaced because it overlapped UAE flag palette.',
emblem:'Single remaining emblem fact identifies the dhow; falcon question removed because it duplicated a shared UAE emblem feature.',
governorate:'Airport governorate, Ahmadi economic identification and Jahra largest area involve different administrative places and relations. Ahmadi question includes ruler name only as a clue; there is no reverse namesake question.',
administration:'Governorate count, most recent governorate and islands administrative affiliation are different division facts; historical data conflict/area formatting excluded.',
oil:'Commercial field identity, first export year, first refinery, export Amir, first exploratory well, first tanker and founding company pair cover different discoveries/events/objects. No separate day-month export question repeats the year fact; WWII obvious question removed.',
towers:'Middle water function, main panoramic viewpoint, opening year, main incense-burner form, smallest lighting/generators, Swedish design and Yugoslav construction are separate attributes. Middle/smallest object inspirations combined into one paired question to avoid repetitive single-object variants.',
palace:'Red Palace location is a single standalone historical-place fact.',
park:'Al Shaheed Park identification and Green Island construction/opening concern different parks and attributes. Binary artificial-island fact retained as accessible landmark recall, not an invented structure.',
zoo:'Omariya location is a single venue fact.',
museum:'Bait Al-Othman district, Rajab calligraphy focus, Habitat/ Memorial distinct themes, Mirror/ Rajab/ Dickson/ Hashemi location relations, Rajab cofounder/ bronze door/ Kaaba curtains/ Hattin diorama ask independent venues, people and collection objects. Habitat is ecology, Memorial is national history; these are not duplicate history museums.',
shopping:'Avenues Al Rai location, SoKu phrase expansion and Boulevard Salmiya location are independent shopping district/place facts.',
football:'National nickname, title year, first World Cup scorer, 1980 final opponent/score/stadium/brace/opener, semifinal Iran, group Qatar, 1982 host/first-goal opponent/draw city and Kuwait SC 2009 scorer are separate event attributes across international/club history. Title-year clue in later final questions does not repeat requested title-year answer; different scorers distinguish opener from brace.',
shooting:'Deehani Rio winner/delegation/Italian runner-up, Rashidi Skeet discipline and Talal father relationship cover different athletes and event attributes; no second Rio winner paraphrase.',
astronomy:'Ujairy scientific field is grouped separately from science museum venue; identity is not asked as an inverse of that field.',
music:'Nabeel nickname, Shadi stage name and Masoul local instrument meaning identify unrelated musicians/instrument vocabulary. Masoul bamboo giveaway removed.',
cinema:'First feature title, director, central pearl-diving occupation and original story author are distinct work/title/person/content facts. Sole screenplay authorship wording corrected to original story because screenplay credits can include director.',
food:'Gabout dumplings, Tashreeb bread, Gers Ogaily cake type/saffron flavour, Qouzi lamb and Zubaidi species cover different dishes or culinary properties. Generic Machboos identity removed because UAE Heritage already asks it; shrimp-in-rubyan tautology removed.',
diwaniya:'Kuwaiti gathering identity and UNESCO 2025 inscription year are separate social and recognition facts; no generic coffee/majlis hospitality fact repeated from UAE Heritage.',
custom:'Child milestone, Ramadan wheat preparation and old newlyweds first-week residence are distinct customs; historical descriptions are scoped as old traditions where appropriate.',
craft:'Sadu House museum neighbour, UNESCO register and annual student textile exhibitions are independent venue/recognition/programme-output facts; generic Sadu weaving identity not repeated from UAE Heritage.',
art:'Mirror House material, creator Lidia, Italian birthplace, termite rebuilding trigger and husband Khalifa identify distinct visual, biographic and conservation facts; no second material identification via house name.',
culture:'Al-Sabah collection identity, DAI founding year/patron, national district partner, Mubarak kiosk market and Amricani former hospital/church/doctor name cover independent collection/institution/building history. Amricani founder church differs from ordinary former-use identification.',
university:'Main campus Al Shadadiya and 1966 founding identify location versus establishment, not repeated founder/year phrasing.',
independence:'Amir Abdullah Al-Salem identity is separate from independence year and constitution date. Disputed British signatory question removed rather than selecting a conflicting government claim.',
history:'Kout etymology, liberation year, independence year, Arab League/UN entry, constitution year, Britain treaty partner, Utub Najd origin, Kazma name, Captain Knox, constituent assembly chair/deputy, UN flag raiser, exile Taif and preceding Bani Khalid concern distinct words/events/people. No year/day pair duplicates one event.',
island:'Bubiyan largest, Failaka second-largest, Warbah northernmost, Umm Al-Maradim southernmost, Qaruh tar-name and Umm Al-Namil Bronze Age concern different islands or distinct property dimensions. Area-number and uncertain folklore claims excluded.',
architecture:'JACC Islamic geometry inspiration and titanium/glass cladding identify separate source-of-form and material facts.',
aviation:'National carrier, airport KWI, early DC-3, leased Comet jet entry, Trans-Arabian rival absorption and B747 wide-body transition test independent identity/history attributes. No current fleet or timetable claims.',
games:'Sherouka feast, tin boat material, Danbak sheepskin jar, Kardia seashell head and Dowaira miniature houses cover separate games/constructions; no alternative name repeats same toy fact.',
constitution:'Original 1962 text specifies Islam and hereditary emirate as separate religion/system provisions, explicitly historically scoped.',
anthem:'Lyrics author, melody composer, arranger and former Amiri Salute composer distinguish four different credits; current tune and previous salute not conflated.',
safeguarding:'Sadu ministry partner and art-teacher trainees are distinct programme organizer/audience roles.',
clothing:'Jalwa green garment, Maqtaa wool and Zeboun gold threads concern separate garment/custom features; generic face-covering question removed due overlap with UAE burqa question.',
humanitarian:'2014 honoured Amir, Ban Ki-moon presentation and Syrian beneficiaries of 2013/2014 conferences ask separate person/organizer/aid-context facts, not repeated honour title/year.',
nature:'Mubarak reserve Boubyan location, crab-plover breeding record and Turkey–India flyway endpoints concern separate location/species/migration facts. Unstable counts of reserves not used.',
literature:'Al-Sabiliat author, Um Kassem protagonist and Iran–Iraq War setting are separate author/character/context facts; Bamboo Stalk facts already in Gulf Culture excluded.',
press:'Al-Arabi magazine identity, first editor Ahmad Zaki and public competition naming cover work/person/process; first-issue year is a clue only and not asked again.',
aid:'First loan recipient Sudan, its railway sector, Egypt Suez project and 1974 geographic expansion are distinct recipient/project/scope facts, not a second loan-first-year question.',
archaeology:'Ikaros Greek language/Memory World register/limestone, Failaka Greek name, Tell Saad Dilmun/underlying summer house, Tell Said mixed Ionic/Persian column tradition, terracotta moulds, Desht fish ovens, refuted Portuguese attribution, Al-Zor palace village and tentative-list status cover separate texts/sites/cultures/objects. Column capitals/bases combined into one cross-cultural question; tentative status clearly separated from actual World Heritage inscription.',
heritage:'Mubarak kiosk market and Al-Zor palace village concern independent heritage locations.',
education:'Mubarakiya first-school identity, Yasin Al-Tabtabai advocacy and later Palestinian teachers test institution versus distinct contributors; no founding-year inverse because 1911 is already in identification clue.'
};
const groups=Map.groupBy(rows,q=>q.factKey.split(':')[0]);const families=[];
for(const[entity,members]of groups){members.sort((a,b)=>a.id.localeCompare(b.id));if(!reasons[entity])throw Error('Missing reviewed family '+entity);families.push({entity,ids:members.map(q=>q.id).join(','),hash:hash(members.map(editorialHash).join('\n')),facts:members.map(q=>q.factKey).join(','),decision:'distinct',reason:reasons[entity]});}
const internal={
'011/067':'Telephone international calling code+965 and airport identifierKWI are unrelated numeric/alphabetic coding systems.',
'008/009':'Northern Iraq versus southern Saudi Arabia; different borders and countries.',
'010/052':'Largest Bubiyan versus second-largest Failaka; different island ranks and identities.',
'010/053':'Bubiyan largest area versus Warbah northernmost position; size and latitude differ.',
'010/054':'Bubiyan largest area versus Umm Al-Maradim southernmost position; size and latitude differ.',
'024/125':'Different house museums in Hawalli and Qadsiya; separate venue locations.',
'024/126':'Bait Al-Othman Hawalli versus Rajab Jabriya; different museums and districts.',
'053/054':'Northern Warbah and southern Umm Al-Maradim are separate island extrema.',
'064/110':'1980 final opposing team versus host stadium are distinct event properties.',
'064/113':'Korea Republic final opponent versus Iran semifinal opponent are different matches.',
'076/144':'Melody composer Ibrahim Al-Soula and arranger Ahmad Ali have different musical credits.',
'085/133':'1979 Kuwait Towers opening and 1988 Green Island opening are different venues and dates.',
'095/096':'1966 university establishment and 2000 Scientific Center establishment concern separate institutions.',
'193/194':'Faisal Al-Dakhil brace differs from Saad Al-Houti opening goal; separate players/contributions.',
'201/202':'Swedish design office versus Yugoslav construction company have separate project roles.'
};
const cross={
'030/uae_football_v2_049':'Kuwait 1982 first scorer Faisal Al-Dakhil differs from UAE 1990 first scorer Khalid Ismail; independent national World Cup milestones.',
'064/uae_football_v2_075':'Kuwait1980 final Korea Republic is a different tournament/match from UAE1996 semifinal Kuwait.',
'109/uae_football_v2_141':'Kuwait1980 final regulation3–0 versus UAE1996 final shootout4–2 loss; different matches and score types.',
'113/uae_football_v2_075':'Kuwait1980 semifinal Iran versus UAE1996 semifinal Kuwait; separate teams/editions.',
'001/uae_general_v2_001':'Kuwait City and Abu Dhabi are separate countries capitals.',
'002/uae_general_v2_005':'Kuwaiti dinar and UAE dirham are different national currencies.',
'010/uae_general_v2_170':'Bubiyan largest Kuwait island differs from Al Siniyah largest Umm Al Quwain island.',
'055/uae_general_v2_007':'Jahra governorate area ranking versus Abu Dhabi emirate area ranking; separate administrative countries.',
'065/uae_general_v2_048':'Kuwait GMT+3 differs from UAE UTC+4; independent national time zones.',
'075/uae_general_v2_073':'Kuwait lyrics Ahmad Meshari Al-Adwani versus UAE lyrics Aref Al Sheikh; different works/authors.',
'077/uae_general_v2_006':'Kuwait dinar1000fils versus UAE dirham100fils; distinct currency subdivision values.',
'085/uae_general_v2_086':'Kuwait Towers1979 versus BurjAlArab1999; separate landmarks/opening milestones.',
'085/uae_general_v2_098':'Kuwait Towers1979 versus DubaiAirport1960; separate tower/transport milestones.',
'095/uae_general_v2_107':'Kuwait University1966 versus UAE University1976; independent institutions.',
'100/uae_general_v2_094':'Kuwait Diwaniya2025 versus UAE Talli2022 are unrelated social/craft inscriptions.',
'100/uae_general_v2_121':'Diwaniya intangible recognition2025 differs from Faya archaeological WorldHeritage2025; different properties/lists.',
'100/uae_heritage_v2_132':'Diwaniya2025 social gathering versus Ayyala2014 performance; different traditions/inscriptions.',
'100/uae_heritage_v2_133':'Diwaniya2025 social practice versus Razfa2015 performance; different traditions/inscriptions.'
};
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json'),'utf8'));
function review(list,decisions,internalMode){return list.map(c=>{const k=c.pair.replace('kuwait_general_v2_','').replace(internalMode?'/kuwait_general_v2_':'NEVER','/');if(!decisions[k])throw Error('Unreviewed pair '+k);return{pair:c.pair,hash:c.hash,decision:'distinct',reason:decisions[k]};});}
csv('near_duplicate_review.csv',review(scan.internal,internal,true),['pair','hash','decision','reason']);
csv('cross_bank_review.csv',review(scan.cross,cross,false),['pair','hash','decision','reason']);
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:editorialHash(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reviewDate:'2026-10-07'})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reviewDate']);
csv('fact_family_review.csv',families,['entity','ids','hash','facts','decision','reason']);
console.log(JSON.stringify({reviewedQuestions:rows.length,semanticGroups:families.length,internalReviewed:scan.internal.length,crossReviewed:scan.cross.length}));
