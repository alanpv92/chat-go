class HasuraQuery {
  static findUserByEmailQuery(email: String) {
    return `
        query MyQuery {
            users(where: {email: {_eq: "${email}"}}) {
              id
              password
              email
              user_name
              salt
            }
          } 
        
        
        `;
  }



  static getUserNotificationToken(userId:String){
    return `
    
    
    query MyQuery {
      usernotifications(where: {user_id: {_eq: "${userId}"}}) {
        notification_token
      }
    }
    
    
    `;
  }
}

export default HasuraQuery;