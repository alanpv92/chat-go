import { body } from "express-validator";

const loginSchema=[
    body("email").isEmail().withMessage("invaild email"),
    body("password").exists().withMessage("password cannot be empty").isLength({min:5}).withMessage("password is short")
];


const registerSchema=[
 ...loginSchema,
 body("user_name").exists().withMessage("user name cannot be empty").isLength({min:5}).withMessage("invaild user name")
];

export default {loginSchema,registerSchema};