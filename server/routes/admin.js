var express = require ('express');
var Router = express.Router ();
var bodyParser = require ('body-parser');

Router.use (bodyParser.json ());


Router.get('/users', (req,res,next) =>{

    var sql = "select * from users;";
    console.log(sql);

    db.query(sql , function(err,result) {
        if(err) {
            console.log(err);
            return console.error(err);
        }
        console.log(JSON.stringify (result));
        res.status(200).send(result);
        
    })


});

Router.get('/hotels', (req,res,next) =>{

    var sql = "select * from hotel;";
    console.log(sql);

    db.query(sql , function(err,result) {
        if(err) {
            console.log(err);
            return console.error(err);
        }
        console.log(JSON.stringify (result));
        res.status(200).send(result);
        
    })


});

module.exports = Router;
