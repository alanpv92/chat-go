import console from "console";
import { Request, Response } from "express";
import HasuraMutation from "../../hasura_queries/mutation";
import HasuraHelper from "../../helpers/hasura/hasura";

const sendChat = async (req: Request, res: Response) => {
  try {
    let { sender_id, receiver_id, message } = req.body;
    let response =await HasuraHelper.getInstance().query(HasuraMutation.sendChat(message,sender_id,receiver_id),req.headers);
    console.log(`response is ${response}`);
    res.json(response);
  } catch (e: any) {
    res.status(401).json({
      error: e.message,
    });
  }
};


export default {sendChat};