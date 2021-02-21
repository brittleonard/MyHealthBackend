const express = require('express');
const router = express.Router();
const postgres = require('../postgres.js');

router.get('/', (req, res) => {
    postgres.query('SELECT * FROM post ORDER BY id ASC;', (err, results) => {
        res.json(results.rows)
    });
});

router.post('/', (req, res) => {
    postgres.query(`INSERT INTO post (name, details) VALUES ('${req.body.name}', ${req.body.details})`, (err, results) => {
        postgres.query('SELECT * FROM post ORDER BY id ASC;', (err, results) => {
            res.json(results.rows)
        });
    })
});

router.delete('/:id', (req, res) => {
    postgres.query(`DELETE FROM post WHERE id = ${req.params.id};`, (err, results) => {
        postgres.query('SELECT * FROM post ORDER BY id ASC;', (err, results) => {
            res.json(results.rows)
        });
    });
});

router.put('/:id', (req, res) => {
    postgres.query(`UPDATE post SET name = '${req.body.name}', AGE = ${req.body.details} WHERE id = ${req.params.id}`, (err, results) => {
        postgres.query('SELECT * FROM post ORDER BY id ASC;', (err, results) => {
            res.json(results.rows)
        });
    })
});

module.exports = router; 
