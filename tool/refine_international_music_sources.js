const fs=require('fs'),p='content/international_music/sources.psv';
let s=fs.readFileSync(p,'utf8');
s+='brubeckpiano|Recording Academy — Dave Brubeck lifetime achievement|https://www.grammy.com/news/grammy-rewind-watch-jazz-pioneer-dave-brubeck-receive-lifetime-achievement-award-1996/|Retrieved or indexed 2026-10-08: Dave Brubeck identified as jazz pianist and composer.\n';
s=s.split(/\r?\n/).map(l=>l.startsWith('havenothingperformer|')?'havenothingperformer|Whitney Houston official — I Have Nothing|https://www.whitneyhouston.com/track/i-have-nothing/|Retrieved or indexed 2026-10-08: I Have Nothing recording and performances by Whitney Houston.':l).join('\n');
fs.writeFileSync(p,s);
