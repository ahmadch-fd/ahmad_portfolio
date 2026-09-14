const http = require('http');
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..', 'build', 'web');
const port = Number(process.env.PORT || 8080);
const host = '127.0.0.1';

const types = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.wasm': 'application/wasm',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
};

http
  .createServer((req, res) => {
    let file = decodeURIComponent(req.url.split('?')[0]);
    if (file === '/' || file === '') {
      file = '/index.html';
    }

    const target = path.join(root, file);
    if (!target.startsWith(root)) {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }

    fs.readFile(target, (error, data) => {
      if (error) {
        fs.readFile(path.join(root, 'index.html'), (fallbackError, fallback) => {
          if (fallbackError) {
            res.writeHead(404);
            res.end('Not found');
            return;
          }

          res.writeHead(200, { 'Content-Type': 'text/html' });
          res.end(fallback);
        });
        return;
      }

      res.writeHead(200, {
        'Content-Type':
          types[path.extname(target).toLowerCase()] || 'application/octet-stream',
      });
      res.end(data);
    });
  })
  .listen(port, host, () => {
    console.log(`Serving Flutter web at http://localhost:${port}`);
  });
