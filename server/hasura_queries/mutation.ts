class HasuraMutation {
  static addUser(
    email: String,
    passwordHash: String,
    userName: String,
    salt: String
  ) {
    return `
        
        mutation MyMutation {
            insert_users_one(object: {email: "${email}", password: "${passwordHash}", user_name: "${userName}",salt: "${salt}"}) {
              id
              email
              user_name
      
            }
          }  
        
        `;
  }

  static sendChat(message: String, senderId: String, receiverId: String) {
    return `
         
      mutation sendChat {
        insert_chats(objects: {is_receiver_read: false, message: "${message}", receiver_id: "${receiverId}", sender_id: "${senderId}"}) {
          affected_rows
          returning {
            id
          }
        }
      }

      `;
  }

  static insertChatPreviewForUser(
    messageId: String,
    user1Id: String,
    user2Id: String
  ) {
    return `
      
    mutation updateChatPreview {
      insert_chatpreview_one(object: {message_id: "${messageId}", user_1_id: "${user1Id}", user_2_id: "${user2Id}"}) {
        id
      }
    }
    
      
    `;
  }

  static updateChatPreviewForUser(chatPreviewId: String, messageId: String) {
    return `
    
    mutation updateChatPreview {
      update_chatpreview(where: {id: {_eq: "${chatPreviewId}"}}, _set: {message_id: "${messageId}"}) {
        affected_rows
      }
    }
    
    
    
    `;
  }

  static clearAllUserStatus() {
    return `
    
    mutation clearAllStatus {
      delete_useronlinestatus(where: {}) {
        affected_rows
      }
    }
      

    `;
  }
}

export default HasuraMutation;
