const promise = require('bluebird');
require('dotenv').config()

const initOptions = {
	promiseLib: promise
};

const config={
	host: process.env.DB_HOST,
	port: 5432,
	database: 'postgres',
	user: process.env.DB_USER,
	password: process.env.DB_PASS
};

const pgp = require('pg-promise')(initOptions);

const db = pgp(config);

module.exports = db;