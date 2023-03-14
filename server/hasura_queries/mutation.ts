class HasuraMutation{
    static addUser(email:String,passwordHash:String,userName:String,salt:String){
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
}

export default HasuraMutation;