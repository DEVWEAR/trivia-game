const fs=require('fs'),d='content/international_music';
// Save the candidate inventory after reading all bilingual drafts, internal pairs,
// protected candidate relations and the four shared-answer pairs in this session.
const scan=JSON.parse(fs.readFileSync(`${d}/similarity_scan.json`)),shared=JSON.parse(fs.readFileSync(`${d}/shared_answer_candidates.json`));
fs.writeFileSync(`${d}/reviewed_pair_inventory.json`,JSON.stringify({internal:scan.internal.map(p=>({pair:p.pair,hash:p.hash})),cross:scan.cross.map(p=>({pair:p.pair,hash:p.hash})),shared},null,2)+'\n');
let p='tool/record_international_music_editorial_review.js',s=fs.readFileSync(p,'utf8').replace('including Egyptian Music','including Egyptian Music and Arabic Music');fs.writeFileSync(p,s);
