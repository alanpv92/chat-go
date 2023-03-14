import { Request, Response } from "express";
import crypto, { BinaryLike } from "crypto";
import jwt from "jsonwebtoken";
import HasuraHelper from "../../helpers/hasura/hasura";
import HasuraQuery from "../../hasura_queries/query";
import HasuraMutation from "../../hasura_queries/mutation";

const generateToken = (data: { id: String; email: String }) => {
  let token = jwt.sign(data, process.env.TOKEN_KEY ?? "", {
    expiresIn: process.env.ACCESS_TOKEN_EXPIRY_TIME,
  });
  return token;
};

const getUserDetailsByEmail = async (email: String) => {
  try {
    let response = await HasuraHelper.getInstance().query(
      HasuraQuery.findUserByEmailQuery(email)
    );

    let user: Array<{
      id: String;
      password: String;
      email: String;
      user_name: String;
      salt: String;
    }> = response["users"] || [];
    return user;
  } catch (e: any) {
    throw new Error("something went wrong");
  }
};

const registerUser = async (req: Request, res: Response) => {
  try {
    let { email, password, user_name } = req.body;
    let user = await getUserDetailsByEmail(email);
    if (user.length != 0) {
      throw new Error("user alredy registred");
    }
    let salt = crypto.randomBytes(16).toString("hex");
    let hash = crypto
      .pbkdf2Sync(password, salt, 1000, 64, `sha512`)
      .toString(`hex`);
    let response = await HasuraHelper.getInstance().query(
      HasuraMutation.addUser(email, hash, user_name, salt)
    );
    let id = response["insert_users_one"]["id"];
    let tokenData = { id, email };
    res.json({
      ...response["insert_users_one"],
      token: generateToken(tokenData),
    });
  } catch (e: any) {
    if (
      (e.message as String).includes(
        "Uniqueness violation. duplicate key value violates unique constraint "
      )
    ) {
      e.message = "user name is not unique";
    }
    res.status(401).json({
      error: e.message || "something went wrong",
    });
  }
};

const loginUser = async (req: Request, res: Response) => {
  try {
    let { email, password } = req.body;
    let user = await getUserDetailsByEmail(email);

    if (user.length == 0) {
      throw Error("user does not exist");
    } else {
      let hash = crypto
        .pbkdf2Sync(password, user[0].salt as BinaryLike, 1000, 64, `sha512`)
        .toString(`hex`);
      if (hash != user[0].password) {
        throw new Error("invaild password");
      }
      let userResponse = {
        id: user[0].id,
        email: user[0].email,
        user_name: user[0].user_name,
      };

      let id = userResponse.id;
      let tokenData = { id, email };

      res.json({
        ...userResponse,
        token: generateToken(tokenData),
      });
    }
  } catch (e: any) {
    res.status(401).json({
      error: e.message,
    });
  }
};

export default {
  loginUser,
  registerUser,
};
