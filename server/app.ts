import express from "express";
import router from "./routes/index";
import weebhook from "./chat-go-hasura/weebhooks/index"

require("dotenv").config();

const app=express();


const port=process.env.PORT||3000

app.use(express.json());


app.use('/webhook',weebhook);


app.use(router);


app.listen(port,()=>{
    console.log(`server is running at ${port}`);
})