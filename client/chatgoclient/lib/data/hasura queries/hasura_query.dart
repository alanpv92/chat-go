class HasuraQuery{
//////////////////////////////////////////////////////////////////////////////////////////////////////  
 static String getAllUsers({required int limit,required int offset}) =>
  """   
   query MyQuery {
  users(limit: $limit, offset: $offset,order_by: {user_name: asc}) {
    email
    id
    user_name
  }
}
""";
//////////////////////////////////////////////////////////////////////////////////////////////////////  



}