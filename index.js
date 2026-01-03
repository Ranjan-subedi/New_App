const express = require("express");
const app = express();
const cors = require("cors");

app.use(express.urlencoded({extended:true}));
app.use(express.json());

const new_router = require("./Routers/route.js");
const DataModel = require("./module/db_schema.js");

app.use(cors());

const mongoose = require("mongoose");


const mongooseUrl = "mongodb+srv://kaskeliranjan_db_user:Ranjan123@newapp.xkyffgl.mongodb.net/?appName=NewApp";

mongoose.connect(mongooseUrl).then(()=>{

    console.log("Mongoose connected successfully");

    
app.get("/",(req,res)=>{
    res.send("Hello World from express server");
    console.log("Hello world from server");
});

app.get("/help",(req,res)=>{
    res.send("This is the help section of the website");
});

app.use("/about",new_router);


});




const PORT = process.env.PORT || 3000;
app.listen(PORT,()=>{
    console.log("Server is running on port 3000");
    console.log("Hello world");

});