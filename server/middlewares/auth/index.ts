import { validationResult } from "express-validator";
import { Request, Response, NextFunction } from "express";

const loginValidator=(req:Request,res:Response,next:NextFunction)=>{
    const errors=validationResult(req);
    if(!errors.isEmpty()){
        return res.status(400).json({
            error: errors.array()[0].msg,
          });
    }
    next();
}

const registerValidator=(req:Request,res:Response,next:NextFunction)=>{
    const errors=validationResult(req);
    if(!errors.isEmpty()){
        return res.status(400).json({
            error:errors.array()[0].msg
        });
    }
    next();
}


export default {loginValidator,registerValidator};