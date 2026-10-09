const fs=require('fs'),d='content/old_school_music';
module.exports=function append(sources,data){
const old=fs.readFileSync(`${d}/sources.psv`,'utf8');
for(const [k,n,u,e]of sources){if(old.split(/\r?\n/).some(l=>l.startsWith(k+'|')))throw Error('Existing source '+k);if(!u?.startsWith('https://'))throw Error('No observed source URL');fs.appendFileSync(`${d}/sources.psv`,[k,n,u,'Retrieved or indexed 2026-10-08: '+e].join('|')+'\n');}
for(const [t,rs]of Object.entries(data)){const lines=fs.readFileSync(`${d}/${t}.psv`,'utf8').trim().split(/\r?\n/),count=lines.length-1;if(count+rs.length>68)throw Error('Tier capacity exceeded');const base={easy:1,medium:69,hard:137}[t];for(const r of rs){if(lines.some(l=>l.split('|')[1]===r[0]))throw Error('Existing fact');}fs.appendFileSync(`${d}/${t}.psv`,rs.map((r,i)=>[String(base+count+i).padStart(3,'0'),...r].join('|')).join('\n')+'\n');}
};
