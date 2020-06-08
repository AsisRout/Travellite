var express = require ('express');
var Router = express.Router ();
var bodyParser = require ('body-parser');

Router.use (bodyParser.json ());

Router.post('/add',(req,res,next) => {
    console.log (req.body);
    const Name=req.body.name ;
    const Email= req.body.email ;
    const Username = req.body.username ; 
    const Password = req.body.password;
 
});

Router.get('/show',(req,res,next) => {

});