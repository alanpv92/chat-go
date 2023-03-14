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
}

export default HasuraQuery;