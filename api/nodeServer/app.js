
/**
 * Module dependencies.
 */

var express = require('express');
var qr = require('./routes/qrcode');
var application = require('./routes/application');
var product = require('./routes/products');
var api = require('./routes/api');
var http = require('http');
var path = require('path');
var app = express();

app.use(express.json());       // to support JSON-encoded bodies
app.use(express.urlencoded()); // to support URL-encoded bodies
app.use(express.bodyParser());
// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
app.use('/public', express.static('public'));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});


app.get('/api/generateSession', api.index);
app.post('/api/sessionShop', api.shop);
app.get('/qr', qr.generate);
app.get('/app', application.app);
app.get('/getProductDetails/:id', product.index);
