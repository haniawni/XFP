var express = require('express');
var router = express.Router();
var db = require('../db');

/* GET home page. */
router.get('/', function(req, res, next) {
	// get from the DB
  db.task('get-projects-and-mtl', t => {
    return t.batch([
        t.manyOrNone("SELECT * FROM projects"),
        t.manyOrNone("SELECT * FROM mtl")
        ]);
  }).then(data => {
    console.log(data);

    // TEST DATA:
    // var tasklist = { 
        // projects: [{1,XFP}],
        // tasks: [
    //   {
    //     name: "eat a bear",
    //     id: 0,
    //     complete_date: null,
    //     project_id: 0
    //   },
    //   {
    //     name: "eat a bagel",
    //     id: 1,
    //     complete_date: null,
    //     project_id: 2
    //   }
    //   ]}
    var locals = {
        projects: data[0],
        tasks: data[1]
    };

    res.render('mtl', locals);
  });
});

module.exports = router;
