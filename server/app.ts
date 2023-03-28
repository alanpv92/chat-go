import express from "express";
import router from "./routes/index";
import weebhook from "./chat-go-hasura/weebhooks/index"
import chatFunctions from "./functions/chats/index";
require("dotenv").config();

const app=express();


const port=process.env.PORT||3000

app.use(express.json());

app.use('/webhook',weebhook);

// chatFunctions.startClearingTimmer();

app.use(router);


app.listen(port,()=>{
    console.log(`server is running at ${port}`);
})