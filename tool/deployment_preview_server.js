// Local-only preview, mounted at the real GitHub Pages project path.
const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '../deployment-preparation/git-working-copy/build/web');
const base = '/trivia-game/';
const types = {'.html':'text/html; charset=utf-8','.js':'application/javascript','.json':'application/json',
  '.wasm':'application/wasm','.jpg':'image/jpeg','.png':'image/png','.svg':'image/svg+xml',
  '.ttf':'font/ttf','.woff2':'font/woff2','.bin':'application/octet-stream'};
if (!fs.existsSync(path.join(root,'index.html'))) throw new Error('Release build is not ready');
http.createServer((req,res) => {
  if (!['GET','HEAD'].includes(req.method)) {res.writeHead(405); return res.end();}
  let pathname;
  try {pathname = decodeURIComponent(new URL(req.url,'http://127.0.0.1').pathname);}
  catch {res.writeHead(400); return res.end();}
  if (pathname === '/' || pathname === '/trivia-game') {
    res.writeHead(302,{Location:base}); return res.end();
  }
  if (!pathname.startsWith(base)) {res.writeHead(404); return res.end();}
  const filename = path.resolve(root,pathname.slice(base.length) || 'index.html');
  if (!filename.startsWith(root + path.sep)) {res.writeHead(403); return res.end();}
  if (!fs.existsSync(filename) || !fs.statSync(filename).isFile()) {res.writeHead(404); return res.end();}
  res.writeHead(200,{'Content-Type':types[path.extname(filename)] || 'application/octet-stream',
    'Cache-Control':'no-store','X-Content-Type-Options':'nosniff'});
  if (req.method === 'HEAD') return res.end();
  fs.createReadStream(filename).pipe(res);
}).listen(8765,'127.0.0.1',() => console.log('Local preview: http://127.0.0.1:8765/trivia-game/'));
