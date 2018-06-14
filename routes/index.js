var express = require('express');
var router = express.Router();
var db = require('../db');

/* GET home page. */
router.get('/', function(req, res, next) {
  	db.any("SELECT * FROM projects").then(function(projects){
  		console.log(projects);

  		res.render('index', { title: 'XFP', projects: projects });
  	});
});

module.exports = router;
