var MongoClient = require('mongodb').MongoClient
    , format = require('util').format;
 var ObjectID = require('mongodb').ObjectID;
exports.index = function(req, res,id){
	/*MongoClient.connect('mongodb://127.0.0.1:27017/products', function(err, db) {
    if(err) throw err;
    console.log("get _id" ,  req.params.id);
    var collection = db.collection('products');
    console.log(collection.findOne);
    collection.findOne({name:"Tshirt"}, console.log)
  	});  // ok*/
	res.writeHead(200, {
	    "Content-Type": "application/json"
	});
	res.end("{'_id':'123','name':'soap','description':'100gm','price':100.5}");
};