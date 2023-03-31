import admin from "firebase-admin";
import { Message } from "firebase-admin/lib/messaging/messaging-api";

const serviceAccountDeatils = require("../../config/firebase-push-notification-key.json");

class FirebaseNotificationService {
  private static instance: FirebaseNotificationService;
  private static firebaseApp: admin.app.App;
  private constructor() {}
  public static getInstance() {
    if (!FirebaseNotificationService.instance) {
      this.instance = new FirebaseNotificationService();
      this.firebaseApp = admin.initializeApp({
        credential: admin.credential.cert(serviceAccountDeatils),
      });
    }
    return this.instance;
  }

  async sendNotification(title: string, body: string, token: string) {
    try {
      const message: Message = {
        notification: {
          title: title,
          body: body,
        },
        token: token,
      };
      
     let response= await admin.messaging().send(message);
     console.log(response);
    } catch (e) {
        console.log("error is",e)
    }
  }
}


export default FirebaseNotificationService;
