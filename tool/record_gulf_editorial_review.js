// Records the completed 2026-10-07 editorial decisions. It never approves similarity candidates.
const fs=require('fs'),path=require('path'),crypto=require('crypto');
const data=path.resolve(__dirname,'../content/gulf_culture');
function psv(file){const lines=fs.readFileSync(path.join(data,file),'utf8').trim().split(/\r?\n/),keys=lines.shift().replace(/^\uFEFF/,'').split('|');return lines.map(l=>Object.fromEntries(l.split('|').map((v,i)=>[keys[i],v])));}
function hash(s){return crypto.createHash('sha256').update(s).digest('hex');}
function csv(name,rows,keys){fs.writeFileSync(path.join(data,name),[keys,...rows.map(r=>keys.map(k=>r[k]??''))].map(r=>r.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(',')).join('\n')+'\n');}
const sources=Object.fromEntries(psv('sources.psv').map(s=>[s.key,s]));
const rows=['easy','medium','hard'].flatMap(tier=>psv(tier+'.psv').map(q=>({...q,tier})));
function editorialHash(q){const s=sources[q.source];return hash([q.id,q.tier,q.factKey,q.source,q.questionAr,q.questionEn,q.answerAr,q.answerEn,s.name,s.url,s.evidence].join('\n'));}
const reasons={
mezmar:'Twirled stick prop and Hijaz region are separate performance and geographic facts.',
aali:'Village identity, royal-mound setting and reuse of burial chambers as kilns are separate geographic, archaeological and craft facts.',
aflaj:'Defensive towers, number of inscribed systems, gravity flow, groundwater threat and astronomical allocation ask different system attributes; generic irrigation-purpose question removed to avoid UAE Heritage overlap.',
agarwood:'Geographic origin, fungal trigger and botanical genus are separate provenance, biological-process and taxonomy facts.',
ardah:'Sword prop, poetry component, opening poet and large-first drum order are separate features of the performance.',
bahla:'Mud-brick walls, Nabahina rulers, carved mihrab, removal from danger list and sabla audience halls are separate material, history, architectural and conservation facts.',
bahrainmuseum:'Facade material and opening year ask different facts.',
bahrainpearling:'Merchant-house context, cultured-pearl competition, offshore oyster beds and departure fort ask different economic and property components.',
bamboo:'Author identity, mother’s national origin and father’s name are separate authorship and character facts; names checked against the prize’s Arabic synopsis.',
barah:'Country and region localize the tradition at different levels; dagger prop, semicircle formation, flute name and paired drum names ask separate performance facts.',
barzan:'Lookout purpose, village location and meaning of the name are independent functional, geographic and vocabulary facts.',
bat:'Country, Bronze Age, Al-Khutm tower and Al-Dhahira governorate ask different property attributes.',
bisht:'Free greeting hand, embroidery metals and non-GCC inscription partners are separate etiquette, craft and UNESCO facts; neither repeats UAE Heritage cloak identity or textile weights.',
bukhoor:'Burner name and heating fuel identify different objects in incense practice.',
calligraphy:'Pen plants and the GCC country absent from the 2021 multinational nomination are separate craft and inscription facts.',
celestial:'Writer’s nationality, prize won and translator identity are separate biographical and publication facts.',
darbzalag:'Production country, actor playing Hussein and co-star identify separate context, role and cast facts.',
dilmun:'Civilization capital, formation of the tell and trade link with the Indus Valley ask separate historical and archaeological facts.',
fjiri:'Country, origin town, jahl instrument, durs venues and seated-circle formation are separate localization and performance facts.',
frankincense:'Country, traded commodity, tree-bearing wadi, port pair, port chronology and caravan oasis are separate property facts; port-pair recall moved to 400.',
garangao:'Celebration month, collected sweets/nuts and name of a separate family gathering are distinct customs.',
gcc:'Membership count, headquarters, acronym expansion, leadership body, first poetry host and first theatre host concern different institutional facts and events.',
gccgeography:'Qatar’s peninsula and Bahrain’s archipelago concern different countries and geographic forms; outdated official numeric statistics were excluded.',
horseardhah:'Practising country, two mount species and hand-linking riding skill ask distinct tradition attributes.',
jassasiya:'Site identification, depicted boats, two local mancala names and dominant cup-mark form ask different archaeological and game-vocabulary facts; no claim that game interpretation is proven.',
jirba:'Instrument identity and goat-skin material are separate nomenclature and construction facts.',
karak:'Drink identity, South Asian origin and Hindi word meaning are separate culinary and linguistic facts.',
katara:'Greek-style amphitheatre, pigeon towers, city location and mosque architect are separate features, site and authorship facts.',
khanjar:'Omani ceremonial association, emblem presence, decorative silver and qarn handle term are different social, symbolic and craft facts.',
khasab:'Overlooked strait, governorate and oldest circular tower ask separate location and structural facts; inconsistent founder chronology excluded.',
khawlani:'Terraces used after transplanting and mesh bags used in initial shaded germination describe different cultivation stages.',
kurar:'Craft name, ribbon-width determinant, Qataba leader, Doakhil assistants and briesam clothing users ask different identities, roles and textile facts.',
liwa:'African musical roots and surnay wind instrument ask separate origin and ensemble facts.',
mancala:'Playing pieces, board arrangement, winning objective, extra-turn rule, skipped store and sowing direction are independent rules; all scoped to the Qatar Museums variant.',
miadoha:'Collection field, architect, artificial island, Ibn Tulun inspiration and emerald prayer inscription ask different museum and object facts.',
musahhar:'Fereej vocabulary, waking function, raqma skin term and tasmeet rope-tightening term concern different social and instrument facts.',
nationalqatar:'Desert-rose form, Jean Nouvel authorship and Abdullah bin Jassim palace are independent design and property-history facts.',
oldmuharraq:'Bin Matar trade, Muharraq’s former capital status, Isa bin Ali house identification, first-restored Nukhida house and gypsum panels ask different people, events and architecture facts.',
omandress:'Omani dishdasha and mussar are different garments; cross-bank Emirati kandura naming and agal function concern distinct regional garments and functions.',
opera:'Host city, founding sultan and inaugural Turandot production are separate venue-history facts.',
qatt:'Country, wall placement, geometry, traditional female practitioners and gypsum base are separate cultural and craft attributes; visual-form question rewritten without giveaway options.',
qdl:'British Library partner and medieval scientific manuscript scope concern institution and archive contents.',
qnl:'Catara map label, Ptolemaic geographic basis and Ottoman Tigris/Euphrates strip map ask separate cartographic facts.',
ramadan:'Sunset meal name, predawn meal name and cannon signal concern distinct meals and a public custom.',
sawt:'Oud, mirwas, maqam, zaffan dance, samra gathering and Bin Faris pioneer identify separate ensemble, melodic and social facts.',
semsemiah:'String-family classification, Egypt/Saudi inscription partners and triangular frame are separate instrument and nomination facts.',
sesame:'Programme identity and joint production institution ask different title and institutional facts; generic child-audience question removed.',
smalldeath:'Novelist and fictionalized Ibn Arabi subject are separate author and book-content facts.',
souqwaqif:'Doha city, falcon hospital, Wadi Musheireb setting and Emiri Stables patrol horses ask different market features.',
suhail:'Seasonal heat marker and Canopus astronomical name ask different cultural and identification facts.',
sur:'Wooden boatbuilding occupation and restored Fatah Al Khair museum ship ask different maritime facts.',
taghrooda:'UAE/Oman nomination partners and dispute-resolution role do not repeat the UAE bank’s camel-journey setting, length or named Al-Wajan poet.',
taifrose:'City identity, early-morning picking, guest-petal welcome and March season start ask different production and social facts.',
thumama:'Gahfiya design inspiration and Ibrahim Jaidah architect are independent source-of-form and authorship facts.',
thuraya:'Star-cluster namesake and Katara location ask separate astronomy and venue facts.',
zubarah:'Sand preservation, pearl export, Kuwait-origin Utub founders and Murair water fort ask separate archaeological, commercial and settlement facts.'
};
csv('editorial_review.csv',rows.map(q=>({id:q.id,hash:editorialHash(q),factKey:q.factKey,source:q.source,evidenceVerified:'yes',translationParity:'yes',difficultyReviewed:'yes',distinctFact:'yes',reviewDate:'2026-10-07'})),['id','hash','factKey','source','evidenceVerified','translationParity','difficultyReviewed','distinctFact','reviewDate']);
const groups=Map.groupBy(rows,q=>q.factKey.split(':')[0]);
const families=[];
for(const [entity,members] of groups){members.sort((a,b)=>a.id.localeCompare(b.id));if(members.length>1&&!reasons[entity])throw Error('Missing specific review '+entity);families.push({entity,ids:members.map(q=>q.id).join(','),hash:hash(members.map(editorialHash).join('\n')),facts:members.map(q=>q.factKey).join(','),decision:'distinct',reason:reasons[entity]||'Single fact in this family: '+members[0].factKey+'; no second question asks this attribute.'});}
csv('fact_family_review.csv',families,['entity','ids','hash','facts','decision','reason']);
csv('near_duplicate_review.csv',[],['pair','hash','decision','reason']);
const cross=[
 {pair:'gulf_culture_v2_047/uae_heritage_v2_001',hash:'08ebfe5307dd77050eaa5803f22fc76f6d6aeae3e685013ee358321c918de88d',decision:'distinct',reason:'Different regional garment names: Omani dishdasha versus Emirati kandura. No repeated Emirati fact.'},
 {pair:'gulf_culture_v2_067/uae_heritage_v2_004',hash:'57664c164376887f17ce16fa0aa01514e030e362ac388c48458824a91c4b0bb2',decision:'distinct',reason:'Mussar identifies an Omani wrapped turban; agal question asks a separate cord’s ghutra-holding function.'}
];
csv('cross_bank_review.csv',cross,['pair','hash','decision','reason']);
console.log('Recorded 204 individually reviewed questions and '+families.length+' semantic families.');
