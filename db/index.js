const promise = require('bluebird');

const initOptions = {
	promiseLib: promise
};

const config={
	host: process.env.DB_HOST,
	port: 5432,
	database: 'public',
	user: process.env.DB_USER,
	pass: process.env.DB_PASS
};

const pgp = require('pg-promise')(initOptions);

const db = pgp(config);

module.exports = db;