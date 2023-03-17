import express from "express";
import authRouter from "./auth/index";
import chatRouter from "./chats/index";

const router = express.Router();

router.use("/auth", authRouter);

router.use("/chat",chatRouter);

export default router;
