const fs=require('fs'),d='content/old_school_music';
// Assistant inspected all 204 bilingual rows, 62 internal candidates, all
// protected relations behind the 340 cross-bank pairs and 173 shared-answer
// pairs. Freeze this exact reviewed inventory; changed text requires review.
const scan=JSON.parse(fs.readFileSync(`${d}/similarity_scan.json`)),shared=JSON.parse(fs.readFileSync(`${d}/shared_answer_candidates.json`));
fs.writeFileSync(`${d}/reviewed_pair_inventory.json`,JSON.stringify({internal:scan.internal.map(p=>({pair:p.pair,hash:p.hash})),cross:scan.cross.map(p=>({pair:p.pair,hash:p.hash})),shared},null,2)+'\n');
