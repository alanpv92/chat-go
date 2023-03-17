import express from "express";
import { Request,Response,NextFunction } from "express";
import authController from "../../controllers/auth/index";
const router =express.Router();


router.use('/',(req:Request,res:Response,next:NextFunction)=>{
  console.log("i am being called",req.baseUrl);
  authController.verifyWebToken(req,res,next);
});



export default router;