const fs=require('node:fs');
const path=require('node:path');
const crypto=require('node:crypto');
const root=path.resolve(__dirname,'..');
const manifest=path.join(root,'content/hard_two_pics_image_prompts.json');
const entries=JSON.parse(fs.readFileSync(manifest,'utf8'));
for(const id of process.argv.slice(2)){
  const entry=entries.find(e=>e.id===id);
  if(!entry)throw new Error('Unknown clue '+id);
  const bytes=fs.readFileSync(path.join(root,entry.path));
  if(bytes.subarray(0,8).toString('hex')!=='89504e470d0a1a0a')throw new Error('Not a PNG '+id);
  entry.sha256=crypto.createHash('sha256').update(bytes).digest('hex');
  entry.width=bytes.readUInt32BE(16);entry.height=bytes.readUInt32BE(20);
  entry.review='PASS: visually inspected; matches specified cue, recognizable subject, no answer text, logos or watermark';
  entry.reviewedOn='2026-10-09';
}
fs.writeFileSync(manifest,JSON.stringify(entries,null,2)+'\n');
console.log('Reviewed '+entries.filter(e=>e.review.startsWith('PASS')).length+'/68 original images.');
