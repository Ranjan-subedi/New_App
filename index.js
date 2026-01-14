const express = require("express");
const app = express();
const cors = require("cors");

app.use(express.urlencoded({extended:true}));
app.use(express.json());

const new_router = require("./Routers/route.js");
const DataModel = require("./module/db_schema.js");

app.use(cors());

const mongoose = require("mongoose");

const dotenv = require("dotenv");
dotenv.config();


const mongooseUrl = process.env.MONGOOSE_DATABASE;

mongoose.connect(mongooseUrl).then(()=>{

    console.log("Mongoose connected successfully");

    
app.get("/",(req,res)=>{
    res.send("Hello World from express server");
    console.log("Hello world from server done");
});

app.get("/help",(req,res)=>{
    res.send("This is the help section of the website");
});


app.put("/update",async(req,res)=>{
  try {
    const updateData = await DataModel.findOneAndUpdate(
      {id: req.body.id},{
        name: req.body.name,
        age: req.body.age,
        city: req.body.city
      },
      {new: true, runValidators: true}
    );

    if (!updateData) {
      return res.status(404).json({message: "Data not found" });
    }

    res.status(200).json({
      message: "Data updated successfully",
      data: updateData
    }); 

  } catch (error) {
    res.status(500).json({message: "Error updating data", error: error.message});
  }
});


app.post("/delete",async (req, res)=>{
  try{
    const result = await DataModel.deleteOne({id : req.body.id});

    if(result.deletedCount === 0){
      return res.status(404).json({message: "Data not found" });
    }else{

    const response = {message: "Data deleted successfully of Id ==> "+ `${req.body.id}`,
    }
    };
    res.status(200).json(response);
  }catch(err){
    res.status(500).json({ message: "Server error" });
  }
});


app.get("/list", async (req, res) => {
  try {
    const dataList = await DataModel.find({});
    res.status(200).json(dataList);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});


app.use("/about",new_router);


});




const PORT = process.env.PORT || 3000;
app.listen(PORT,()=>{
    console.log("Server is running on port 3000");
    console.log("Hello world");

});