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
}

export default HasuraMutation;
