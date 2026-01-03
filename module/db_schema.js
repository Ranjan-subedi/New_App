const express = require("express");
const mongoose = require("mongoose");

const app_schema = new mongoose.Schema({
    id:{
        type:String,
        required:true,
        unique:true
    },
    name: {type:String,
        required:true,
    },
    age: {type:String,
        required:true
    },
    city: {type:String,
        required:true
    }
});


module.exports = mongoose.model("DataModel", app_schema);