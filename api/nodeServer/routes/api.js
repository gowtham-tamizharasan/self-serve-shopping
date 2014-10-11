var MongoClient = require('mongodb').MongoClient
    , format = require('util').format;

exports.index = function(req, res){
	MongoClient.connect('mongodb://127.0.0.1:27017/session', function(err, db) {
    if(err) throw err;
    var collection = db.collection('session');
    var sessionId=Math.floor(Math.random()*90000) + 10000;
 	collection.insert({"_id":sessionId}, function(err, docs) {
 		res.send(""+sessionId);
    });
  })
};

exports.shop = function(req, res){
	var productDetails=JSON.parse(req.body.product);
	console.log("product---->",productDetails);
	var sessionId=req.body.session;
	MongoClient.connect('mongodb://127.0.0.1:27017/session', function(err, db) {
	    if(err) throw err;
	    var collection = db.collection('session');
	    console.log("sessionId---->",parseInt(sessionId));
	 	collection.update({"_id":parseInt(sessionId)},{"$set":{"purchase":productDetails} }, function(err, docs) {

	 		if(!err){
	 			res.send("Success");	
	 		}else{
	 			res.send("Fail--> "+err);
	 		}
	    });
  	})
};