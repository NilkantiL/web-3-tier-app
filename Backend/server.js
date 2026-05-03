const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());

mongoose.connect("mongodb://mongodb:27017/mydb");

app.get("/", (req, res) => {
  res.send("Backend working 🚀");
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
