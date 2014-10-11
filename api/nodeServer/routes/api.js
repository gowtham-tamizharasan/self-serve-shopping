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
	var sessionId=req.param('session');
	console.log("product---->",req.param('product'),req.param('session'),req);
	var productDetails=JSON.parse(req.param('product'));
	MongoClient.connect('mongodb://127.0.0.1:27017/session', function(err, db) {
	    if(err) throw err;
	    var collection = db.collection('session');
	 	collection.update({"_id":sessionId},productDetails, function(err, docs) {
	 		if(!err){
	 			res.send("Success");	
	 		}else{
	 			res.send("Fail");
	 		}
	    });
  	})
};