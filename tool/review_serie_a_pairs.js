const fs=require('fs'),path=require('path');const dir=path.resolve(__dirname,'../content/serie_a');const s=JSON.parse(fs.readFileSync(path.join(dir,'similarity_scan.json'),'utf8'));
const internal={
'003/034':'Milan-Inter Madonnina and Juventus-Torino Mole are different city derbies and club pairs.',
'007/032':'Milan Rossoneri red/black and Roma Giallorossi yellow/red are independent club colour identities.',
'011/021':'Pioli Milan 2022 and Spalletti Napoli 2023 refer to different coaches, clubs and campaigns.',
'011/154':'Pioli Milan 2022 and Bernardini Bologna 1964 refer to different coaches and championships.',
'014/124':'Capello Roma 2001 and Sarri Juventus 2020 identify different coaching achievements.',
'021/154':'Spalletti Napoli 2023 and Bernardini Bologna 1964 concern different campaigns and coaches.',
'033/034':'Genoa-Sampdoria Lanterna and Juventus-Torino Mole concern different derby pairings.',
'045/077':'Simone Inzaghi Inter 2024 and Boskov Sampdoria 1991 are different championship coaches.',
'045/163':'Simone Inzaghi Inter 2024 and Bianchi Napoli 1987 concern different clubs, coaches and titles.',
'077/163':'Boskov Sampdoria 1991 and Bianchi Napoli 1987 identify different maiden-title coaches.',
'043/088':'Lookman 2024 Europa League final and Domenghini 1963 Coppa Italia final concern separate hat-tricks, opponents and competitions.',
'161/183':'Tabanelli Atalanta 1963 and Guidolin Vicenza 1997 concern different domestic cup campaigns.',
'182/191':'Boffi Milan 1939 and Brighenti Sampdoria 1961 concern different first club scoring-title winners.'
};
const decisions={};for(const c of s.internal){const key=c.pair.replaceAll('serie_a_v2_','');if(!internal[key])throw Error('Review required '+key);decisions[c.pair]={hash:c.hash,reason:internal[key]};}
for(const c of s.cross){let reason;
 if(c.factA.startsWith('derby:')&&/derb[yi]/i.test(c.questionB))reason='These questions identify separate city derbies: '+c.answerA+' versus '+c.answerB+'. Their club pairs and locations differ.';
 else if(c.factA.startsWith('stadium:parma:'))reason='Parma home Ennio Tardini is a separate venue from '+c.answerB+' belonging to a different club in the completed bank.';
 else if(c.factA==='title:napoli:firstyear')reason='Napoli first Italian title in 1987 differs from the completed UAE club or national-team first title; the competition and champion differ.';
 else if(c.factA==='history:sampdoria:merger')reason='Sampdoria merger of Sampierdarenese and Andrea Doria in 1946 differs from the independent founding merger in the other question: '+c.answerB+'.';
 else if(c.factA==='history:singleleague:firstchampion')reason='Inter first single-group Italian champion 1929/30 differs from Barcelona first Spanish champion 1929; these are different domestic competitions.';
 else if(c.factA==='stadium:lecce:viadelmare')reason='Lecce plays at Via del Mare; Valladolid plays at Jose Zorrilla. Separate club/ground relations.';
 else if(c.factA==='stadium:bologna:namesake')reason='Renato Dall Ara is Bologna stadium namesake; Santiago Bernabeu is the Real Madrid stadium and its namesake. Separate clubs and presidents.';
 else if(c.factA.startsWith('coach:lazio2000:')||c.factA.startsWith('coach:cagliari1970:'))reason='Italian champion coach '+c.answerA+' differs from Valencia 2002 coach Rafa Benitez; both club and campaign differ.';
 else if(c.factA==='history:cavani:napoliprevious')reason='Cavani moved Palermo-to-Napoli in 2010; Villa moved Valencia-to-Barcelona. Different players, origins and destinations.';
 else throw Error('Unreviewed cross candidate '+c.pair);
 decisions[c.pair]={hash:c.hash,reason};}
fs.writeFileSync(path.join(dir,'editorial_decisions.json'),JSON.stringify(decisions,null,2)+'\n');
const shared=JSON.parse(fs.readFileSync(path.join(dir,'shared_answer_candidates.json'),'utf8'));
const reasons={
'022':'Juventus unbeaten 2012 title is independent of Luca Toni or Vucinic later moving from Juventus to a UAE club.',
'035':'Fiorentina traditional purple and Al Ain adopting purple in 1977 concern different club identities.',
'057':'Juventus 2006 Calciopoli relegation differs from subsequent player transfers to UAE clubs.',
'156':'Benfica as Torino last friendly opponent before Superga is unrelated to Seferovic or Taarabt moving from Benfica to UAE clubs.',
'017':'Buffon professional debut at Parma is a different career event from Zola transfer Parma-to-Chelsea.',
'020':'Mourinho Inter treble 2010 differs from Chelsea Special One introduction and Real Madrid 100-point title 2012.',
'068':'Parma 1999 UEFA Cup winning team differs from Zola leaving Parma for Chelsea in 1996.',
'111':'Ancelotti tactical use of Pirlo at Milan differs from Ancelotti Chelsea 2009/10 league title.',
'127':'Dzeko Roma 2017 scoring title differs from his Manchester City 2012 QPR equaliser.',
'190':'Sacchi move Parma-to-Milan as coach differs from Zola move Parma-to-Chelsea as player.',
'014':'Capello Roma league title 2001 differs from his Real Madrid league titles in 1997 and 2007.',
'049':'Zamorano Inter 1+8 shirt differs from his Bam Bam nickname and Real Madrid Clasico hat-trick in 1995.',
'060':'Barcelona as Maradona transfer origin in 1984 differs from first Spanish champion 1929 and Riquelme Villarreal transfer origin 2005.'
};
fs.writeFileSync(path.join(dir,'shared_answer_review.json'),JSON.stringify(shared.map(c=>{const id=c.pair.split('/')[0].slice(-3);if(!reasons[id])throw Error('Shared review '+id);return {...c,decision:'distinct',reason:reasons[id]}}),null,2)+'\n');
