var bee = require("beeline");
var http = require("http");
var fs = require("fs");
var nowjs = require("now");
var brain = require("brain");

var cache = {};
cache['index'] = fs.readFileSync('./draw.html');
cache['app'] = fs.readFileSync('./neurotype_draw.pde')

var net = new brain.NeuralNetwork({
   hiddenLayers: [4],
   learningRate: 0.6
});


var router = bee.route({ // Create a new router
	"/": function(req, res) {
		console.log("served home");
       	res.writeHead(200, {"Content-Type": "text/html"});
	    res.write(cache['index']);
	    res.end();
    },
	"/neurotype_draw.pde": function(req, res) {
		console.log("served app");
       	res.writeHead(200, {"Content-Type": "text/html"});
	    res.write(cache['app']);
	    res.end();
    },
	
    "`404`": function(req, res) {
        
    },
    "`503`": function(req, res, err) {
        
    }
});

httpServer = http.createServer(router).listen(8888);

var everyone = nowjs.initialize(httpServer);

everyone.now.distribute = function(r,g,b,rad,x,y){
  // this.now exposes caller's scope
	console.log(r);
  everyone.now.receive(r,g,b,rad,x,y);
};