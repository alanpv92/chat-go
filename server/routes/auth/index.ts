import express from "express";
import authController from "../../controllers/auth/index";
import authSchema from "../../schema/auth/index";
import authValidator from "../../middlewares/auth/index";


const router=express.Router();


router.post("/login",authSchema.loginSchema,authValidator.loginValidator,authController.loginUser);

router.post("/register",authSchema.registerSchema,authValidator.registerValidator,authController.registerUser);

export default router;