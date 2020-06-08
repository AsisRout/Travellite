var express = require ('express');
var Router = express.Router ();
var bodyParser = require ('body-parser');

Router.use (bodyParser.json ());


Router.get('/', (req,res,next) =>{

    const city = req.query.city;

    var sql = "call get_hotel_from_city('" + city + "');";
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
