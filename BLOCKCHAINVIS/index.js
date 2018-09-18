var express = require('express');
var ejs = require('ejs');
var app = express();
app.set('view engine', 'ejs');
app.use(express.static('public'));

app.listen(3000);