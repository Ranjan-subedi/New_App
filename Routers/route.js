const express = require("express");
const router = express.Router();
const DataModel = require("../module/db_schema.js");

router.get("/",function(req,res){
    console.log("This is about route");
    res.send("This is about route");
});

router.post("/add",async function(req,res){
    console.log("This is add route");
    console.log("Request Body:", req.body);
    try {

        personData = {
            id: req.body.id,
            name: req.body.name,
            age: req.body.age,
            city: req.body.city
        };

        const newData = new DataModel(personData);
        await newData.save();


    
        res.status(201).json({
            "status":"Added to database",
            "data":personData});

        console.log("Response sent successfully");
        
    } catch (error) {
        if (error.code === 11000) {
            // Duplicate name
            res.status(400).json({
                status: "fail",
                message: "Name must be unique!"
            });
        } else if (error.name === "ValidationError") {
            // Mongoose validation error
            res.status(400).json({
                status: "fail",
                message: error.message
            });
        } else {
            res.status(500).json({
                status: "error",
                message: "Internal Server Error"
            });
        }


    }

});

module.exports = router;