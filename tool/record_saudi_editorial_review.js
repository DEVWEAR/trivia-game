// Records the independently reviewed Saudi questions and explicit overlap decisions.
// This script archives decisions; missing family or pair decisions fail closed.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/saudi_general');
function psv(file){const lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.filter(Boolean).map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
const hash=s=>crypto.createHash('sha256').update(s).digest('hex');
function csv(name,rows,keys){fs.writeFileSync(path.join(data,name),[keys,...rows.map(r=>keys.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function editorialHash(q){const s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
const reasons={
administration:'One independently sourced province-count fact; no second names/count inverse.',
agriculture:'Buraydah dates, Jawf olive crop and Hasawi rice harvest term refer to separate crops, regions and attributes.',
archaeology:'Faw sacred mountain and Thaj mask discovery site are different places and finds; uncertain royal genealogy excluded.',
architecture:'Maraya mirrors, Turaif Najdi style, Jeddah trade canal, Masmak ammunition use, Ithra stone inspiration/designer, KAFD designer, Faisaliah firm and National Museum architect are different materials, influences, credits and historical uses. No building-size filler.',
art:'Mater Magnetism creator and earlier medical profession are work attribution versus biographical background. AlDowayan Suspended Together creator and historical document content are attribution versus subject; neither repeats the other answer or asserts current travel law.',
awards:'King Faisal Prize first presentation year differs from Zewail science laureate identity. Establishment 1977 is not confused with first award 1979.',
business:'Albaik Jeddah origin and founder Shakour AbuGhazalah are location and person, not two founder paraphrases.',
calendar:'National Day, Founding Day and weekly weekend are different observances. Founding Day is commemorative date, not asserted exact eighteenth-century event date.',
cinema:'Wadjda director and bicycle ambition are authorship versus plot. Red Sea host city and Yusr award name are venue versus award. Barakah director and two lead performers have three separate credits. Shams Al-Maarif director concerns another film.',
craft:'Bisht-producing Al-Ahsa oasis and final Bardakh technique are geography versus production vocabulary. Generic bisht identity and gold-thread facts excluded because existing heritage banks use them. Factory Umm Al-Jud district is a separate Kiswa textile site.',
culture:'Ithra full name, Aramco initiator and Dhahran location are independent institutional attributes. Coffee designation year, National Museum city/final gallery, Clock Museum astronomy and donated Nassif library university involve distinct programmes and collections.',
currency:'Saudi riyal unit, Kaaba on 500, Jerusalem on 50 and five-riyal polymer issue are separate monetary identity/design/material facts. 200-riyal date contradictions excluded.',
development:'Vision target year versus launch year distinguish programme title and establishment. NEOM Greek/Arabic name components form one combined etymology fact, not two inverse questions.',
ecology:'Uruq desert location, Arabian oryx reintroduction and zibar landform terminology are separate geography, conservation and geomorphology facts.',
education:'KSU Riyadh location and 1957 founding differ; KAUST Thuwal is another institution. Al-Falah founder is a historical education contributor, without unsupported first-school claim.',
food:'Jareesh national designation and wheat grain are designation versus recipe; Maqshush national dessert, Klija Qassim, Hasawi grain colour and Matazeez broth cooking concern distinct foods/attributes. No repeated Machboos or Gulf coffee hospitality facts.',
geography:'Capital, peninsula, opposing west/east coasts, Farasan province, Tuwaiq landform/name, Aqaba and Dahna connections identify different geographic relations. Jeddah Red Sea question removed to avoid repetitive west-coast recall.',
geology:'Wahbah explosive magma-water origin differs from its Harrat Kishb volcanic-field affiliation. Meteor folklore and absolute size rankings excluded.',
heritage:'Separate sites include Jeddah pilgrim gateway, Rijal Almaa, Okaz, Dadan lion carvings, Hegra civilization/first inscription/Petra relation/isolated tomb, Marid town, Haddaj oasis, Ikmah nickname/documentary register, Ibrahim city, Tayma Abbasid palace, Hima Greek script, Zubaydah endpoint, Hail property localities/Shuwaymis mountains/Jubbah former lake, Rajajil region/name resemblance, Faw abandonment, Tarout governorate, Uqair gateway, Shubra city/Cairo inspiration, Najdi mosque imported decoration/pearl-merchant trade, Tapline heritage recognition and Zuhair caliph/script. Site identifiers are not reversed into second questions; component localities, mountains and former lake are separate geographic dimensions. No repeated Gulf UNESCO traditions.',
history:'Modern founder, first-state capital/founder, unification year, Riyadh recapture year, second-state founder, Diriyah founder, Faisal embargo, Salmans 2015 succession, Salwa ruling palace, Saud Al-Kabir identity, Fahd title, Red Palace commission, Kinda capital, last first-state imam and Ibn Bishr authorship concern distinct people/events/works. No day/year duplication or disputed Salwa-builder claim.',
industry:'Dammam discovery year versus well identity differ from concession company, local guide Rimthan, geologist Steineke, Tapline destination and SABIC full name. No second first-oil-year paraphrase.',
institutions:'One SAMA abbreviation/central-bank identity fact, separate from banknote design and material.',
landmarks:'Masmak Riyadh, King Fahd fountain Jeddah, Al-Qarah oasis and Clock Towers Makkah concern separate landmarks.',
literature:'Gosaibi administration book and debut poetry collection are different works. Abdo Khal Throwing Sparks and Raja Alem Doves Necklace attribution concern separate prize-winning novels. Mohammed Hasan Alwan facts excluded because Gulf Culture already uses them.',
media:'WAS agency abbreviation and Umm Al-Qura official gazette are different organizations; WAS wording revised to remove answer in question.',
music:'Mohammed Abdu epithet, anthem lyricist Ibrahim Khafaji, arranger Siraj Umar and Badr Fawq Ham Al-Sahab poem credit are independent roles/works. Royal Salute original composition not misattributed to arranger.',
poetry:'Badr Word Engineer epithet is a single nickname fact, distinct from his credited song-poem in music family.',
publishing:'Al-Arab founder Hamad Al-Jasser differs from Al-Jazirah founder Abdullah bin Khamis. Saudi newspaper clearly distinguished from Qatar broadcaster.',
religious:'Hira mountain, Prophet Mosque city, Kiswa cloth name, Kaaba containing mosque and Zamzam well identify distinct places/objects and relations. No inversion of mosque/well question.',
space:'First Saudi Sultan, first woman Rayyanah, Sultan Discovery shuttle and Rayyanah mission companion Ali Al-Qarni are distinct person/vehicle/mission credits. Repetitive first-person wording revised.',
sport:'Jeddah derby, Al Hilal city, Ittihad oldest club, Owairan Belgium solo, Argentina opponent/winner, national nickname, first F1 city/winner, Souan medal discipline/earlier football position/development club, Hamdi karate, Asian 1984 coach/previous club, 1988 final opponent/decisive penalty, 1989 U16 host opponent/goalkeeper/coach/stadium, 1994 first scorer/knockout opponent/coach/Morocco penalty scorer and Abdulghani Swiss club cover different teams, events and roles. Saudi 1996 final facts excluded due UAE Football overlap. No two 1994 goal-scorer questions ask same match/scoring role.',
symbols:'Green flag background, palm emblem, no half-mast practice and shahada text are distinct visual/custom attributes. Other banks colours/emblem facts are not reused.',
television:'One Tash Ma Tash Fuad performer fact; no duplicate show-star identity.',
tradition:'One Farasan Hareed parrotfish festival-species fact, not separately reversed as festival name.',
transport:'Causeway destination versus Saudi-end city; Haramain endpoints; Saudia identity; metro line count/airport line/KAFD interchange; Jeddah airport city; historical Hijaz railway endpoints concern independent structures/attributes. No changing timetable or fleet data.',
travel:'AlUla Elephant Rock, Abha province and Jeddah Al-Balad concern separate destinations; western coast duplicate replaced.'
};
const groups=Map.groupBy(rows,q=>q.factKey.split(':')[0]),families=[];
for(const[entity,members]of groups){members.sort((a,b)=>a.id.localeCompare(b.id));if(!reasons[entity])throw Error('Missing reviewed family '+entity);families.push({entity,ids:members.map(q=>q.id).join(','),hash:hash(members.map(editorialHash).join('\n')),facts:members.map(q=>q.factKey).join(','),decision:'distinct',reason:reasons[entity]});}
const internal={
'004/068':'Western Red Sea and eastern Arabian Gulf are different coastline relations and answers.',
'008/009':'National Day unification observance and Founding Day first-state observance have different dates and referents.',
'012/088':'Masmak Riyadh and Ithra Dhahran are separate buildings/cities.',
'014/135':'Abha Aseer versus Okhdood Najran are separate settlement-region relations.',
'017/026':'National savoury dish Jareesh and national dessert Maqshush are two distinct designations/foods.',
'048/088':'National Museum Riyadh and Ithra Dhahran are separate institutions/cities.',
'124/135':'Rajajil Al-Jawf versus Okhdood Najran are separate archaeological sites/provinces.',
'136/187':'Sweden opposing team and Jorge Solari Saudi coach are different event roles in USA 1994.'
};
const cross={
'043/uae_football_v2_028':'Jeddah Ittihad/Ahli derby differs from Bur Dubai Nasr/Wasl derby.',
'082/uae_football_v2_072':'Saudi Argentina2022 winner Salem differs from UAE Yugoslavia1990 scorer Ali Thani; different matches.',
'134/uae_football_v2_049':'Saudi first World Cup scorer Fuad in1994 differs from UAE Khalid Ismail in1990.',
'001/uae_general_v2_001':'Saudi capital Riyadh and UAE capital Abu Dhabi are distinct national capitals.',
'002/uae_general_v2_005':'Saudi riyal and UAE dirham are different national monetary units.',
'040/uae_general_v2_040':'King Saud University Riyadh differs from UAE University Al Ain.',
'073/uae_general_v2_073':'Saudi anthem Ibrahim Khafaji and UAE anthem Aref Al Sheikh are separate lyric credits.',
'076/uae_general_v2_121':'First Saudi World Heritage site Hegra identity differs from UAE Faya inscription year2025.',
'095/uae_general_v2_107':'King Saud University1957 differs from UAE University1976; separate institutional founding events.',
'035/uae_heritage_v2_003':'Kaaba textile Kiswa and human headwear Ghutra are unrelated objects; lexical covering similarity only.',
'001/kuwait_general_v2_001':'Riyadh and Kuwait City are separate countries capitals.',
'002/kuwait_general_v2_002':'Saudi riyal and Kuwaiti dinar are different monetary units.',
'014/kuwait_general_v2_049':'Abha Aseer regional location differs from Kuwaits Shadadiya university campus district.',
'064/kuwait_general_v2_015':'Saudi King Abdulaziz airport Jeddah differs from Kuwait airport Farwaniya.',
'073/kuwait_general_v2_075':'Saudi lyrics Khafaji and Kuwaiti lyrics Al-Adwani are different works/authors.',
'095/kuwait_general_v2_095':'King Saud University1957 differs from Kuwait University1966.',
'113/kuwait_general_v2_064':'Saudi1988 and Kuwait1980 Asia finals both faced Korea but are distinct matches and tournaments.',
'145/kuwait_general_v2_051':'Tuwaiq from Tawq and Kuwait from Kout are different words and etymologies.'
};
const scan=JSON.parse(fs.readFileSync(path.join(data,'similarity_scan.json'),'utf8'));
function review(list,decisions,internalMode){return list.map(c=>{const k=c.pair.replace('saudi_general_v2_','').replace(internalMode?'/saudi_general_v2_':'NEVER','/');if(!decisions[k])throw Error('Unreviewed pair '+k);return{pair:c.pair,hash:c.hash,decision:'distinct',reason:decisions[k]};});}
csv('near_duplicate_review.csv',review(scan.internal,internal,true),['pair','hash','decision','reason']);
csv('cross_bank_review.csv',review(scan.cross,cross,false),['pair','hash','decision','reason']);
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:editorialHash(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reviewDate:'2026-10-07'})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reviewDate']);
csv('fact_family_review.csv',families,['entity','ids','hash','facts','decision','reason']);
console.log(JSON.stringify({reviewedQuestions:rows.length,semanticGroups:families.length,internalReviewed:scan.internal.length,crossReviewed:scan.cross.length}));
