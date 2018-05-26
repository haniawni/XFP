var express = require('express');
var router = express.Router();
var db = require('../db');

/* GET home page. */
router.get('/', function(req, res, next) {
	// get from the DB
  res.render('mtl', { tasks: [
  	{
  		name: "eat a bear",
  		id: 0,
  		complete_date: null,
  		project_id: 0
  	},
  	{
  		name: "eat a bagel",
  		id: 1,
  		complete_date: null,
  		project_id: 2
  	}
  	]});
});

module.exports = router;
