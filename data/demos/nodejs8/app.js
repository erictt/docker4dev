var http = require('http');
console.log("Running on port: 3000 (Press CTRL+C to quit)")
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.write('Hello, Nodejs8!');
  res.end();
}).listen(3000);
