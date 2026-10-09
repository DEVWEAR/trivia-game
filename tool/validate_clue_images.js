const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const root = path.resolve(__dirname, '..');
const hash = bytes => crypto.createHash('sha256').update(bytes).digest('hex');
const entries = JSON.parse(fs.readFileSync(path.join(root, 'content/hard_two_pics_image_prompts.json'), 'utf8'));
if (entries.length !== 68) throw Error('Expected 68 original images');
const rows = fs.readFileSync(path.join(root, 'lib/data/questions/two_pics_questions_069_102.dart'), 'utf8');
const cards = [...rows.matchAll(/_p600\('([^']+)','([^']+)','([^']+)','([^']+)','([^']+)'\)/g)];
if (cards.length !== 34) throw Error('Expected 34 unchanged hard cards');
const ids = new Set(), hashes = new Set();
let bytesTotal = 0;
for (const entry of entries) {
  if (ids.has(entry.id)) throw Error('Duplicate image ID');
  ids.add(entry.id);
  const card = cards.find(c => c[1] === entry.card);
  const side = Number(entry.id.split('_')[1]);
  if (!card || card[2] !== entry.answerAr || card[3] !== entry.answerEn || card[3 + side] !== entry.cue) throw Error('Clue mismatch: ' + entry.id);
  if (entry.path !== 'two_pics/' + entry.id + '.png' || !entry.review.startsWith('PASS') || !entry.prompt || !entry.origin.startsWith('Original built-in')) throw Error('Missing reviewed provenance: ' + entry.id);
  const bytes = fs.readFileSync(path.join(root, entry.path));
  if (bytes.subarray(0,8).toString('hex') !== '89504e470d0a1a0a' || bytes.readUInt32BE(16) !== entry.width || bytes.readUInt32BE(20) !== entry.height || entry.width < 500 || entry.height < 500) throw Error('Invalid image: ' + entry.id);
  const digest = hash(bytes);
  if (digest !== entry.sha256 || hashes.has(digest)) throw Error('Hash mismatch or duplicate image: ' + entry.id);
  hashes.add(digest); bytesTotal += bytes.length;
  if (process.argv.includes('--build') && hash(fs.readFileSync(path.join(root, 'build/web/assets', entry.path))) !== digest) throw Error('Bundled image differs: ' + entry.id);
}
for (let n = 1; n <= 68; n++) for (let side = 1; side <= 2; side++) {
  const key = 'assets/two_pics/' + String(n).padStart(3,'0') + '_' + side + '.jpg';
  const bytes = fs.readFileSync(path.join(root,key));
  if (!bytes.length) throw Error('Empty existing image');
  if (process.argv.includes('--build') && hash(fs.readFileSync(path.join(root,'build/web/assets',key))) !== hash(bytes)) throw Error('Existing bundled image differs');
}
console.log(JSON.stringify({status:'PASS',originalImages:68,hardCards:34,totalClueImages:204,reviewed:68,duplicateHashes:0,provenanceErrors:0,bundledChecked:process.argv.includes('--build'),newImageBytes:bytesTotal}));
