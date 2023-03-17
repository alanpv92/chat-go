import express from "express";
import chatController from "../../controllers/chats/index";
const router=express.Router();

router.post("/sendchat",chatController.sendChat);




export default router;