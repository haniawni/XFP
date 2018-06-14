var express = require('express');
var router = express.Router();
var db = require('../db');

/* GET home page. */
router.get('/:project_id', function(req, res, next) {
	// get from the DB
  db.task('get-projects-and-mtl', t => {
    console.log(req.params)
    return t.batch([
        t.oneOrNone("SELECT name FROM projects WHERE id = $1", [req.params['project_id']]),
        t.manyOrNone("SELECT * FROM mtl WHERE project_id = $1", [req.params['project_id']])
        ]);
  }).then(data => {
    console.log(data);

    var locals = {
        name: data[0]['name'],
        tasks: data[1]
      }
    console.log(locals);
      res.render('ptl', locals);
    });
  
});

module.exports = router;
