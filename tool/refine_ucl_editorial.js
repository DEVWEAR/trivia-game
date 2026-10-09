const fs=require('fs'),path=require('path');
const dir=path.resolve(__dirname,'../content/ucl');
function read(t){let lines=fs.readFileSync(path.join(dir,t+'.psv'),'utf8').trim().split(/\r?\n/);return {head:lines.shift(),lines};}
const banks=Object.fromEntries(['easy','medium','hard'].map(t=>[t,read(t)]));
function exchange(t1,id1,t2,id2){let i=banks[t1].lines.findIndex(l=>l.startsWith(id1+'|')),j=banks[t2].lines.findIndex(l=>l.startsWith(id2+'|'));let a=banks[t1].lines[i].split('|'),b=banks[t2].lines[j].split('|');a[0]=id2;b[0]=id1;banks[t1].lines[i]=b.join('|');banks[t2].lines[j]=a.join('|');}
// Origi's memorable final goal belongs at 200; the 1993 qualifying upset at 600.
exchange('easy','045','hard','151');
exchange('medium','131','hard','151');
// The captain is easier to recall than an injury replacement in the final.
exchange('medium','077','hard','160');
for(const [t,b] of Object.entries(banks))fs.writeFileSync(path.join(dir,t+'.psv'),b.head+'\n'+b.lines.join('\n')+'\n');
