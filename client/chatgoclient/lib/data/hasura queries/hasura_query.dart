class HasuraQuery {
//////////////////////////////////////////////////////////////////////////////////////////////////////
  static String getAllUsers({required int limit, required int offset}) => """   
   query MyQuery {
  users(limit: $limit, offset: $offset,order_by: {user_name: asc}) {
    email
    id
    user_name
      chatpreviews {
      id
    }
    chatpreviewsBySenderId {
      id
    }
  }
  
}
""";

//////////////////////////////////////////////////////////////////////////////////////////////////////

  static String getUserBySearchQuery({required String searchQuery}) => """

  query MyQuery {
  users(order_by: {user_name: asc}, where: {user_name: {_ilike: "$searchQuery%"}}) {
    email
    id
    user_name
  }
}


""";

//////////////////////////////////////////////////////////////////////////////////////////////////////

  static String getUserChat(
          {required String senderId, required String receiverId}) =>
      '''
query getAllUserChats {
  chats(where: {_or: [
    {sender_id: {_eq: "$senderId"}, receiver_id: {_eq: "$receiverId"}},
    {receiver_id: {_eq: "$senderId"}, sender_id: {_eq: "$receiverId"}}  
  ]}) {
    message
    is_receiver_read
    id
    receiver_id
    sender_id
  }
}

''';

///////////////////////////////////////////////////////////////////////////////////////////////////////

  static String getUserChatCount(
          {required String senderId, required String receiverId}) =>
      '''
query getUserChatCount {
  chats_aggregate(where: {_or: [{sender_id: {_eq: "$senderId"}, receiver_id: {_eq: "$receiverId"}}, {receiver_id: {_eq: "$senderId"}, sender_id: {_eq: "$receiverId"}}]}) {
    aggregate {
      count
    }
  }
}
''';

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String getUserLatestChats(
          {required String senderId, required String receiverId,required int limit}) =>
 '''
query getLatestUserChats {
  chats(where: {_or: [{sender_id: {_eq: "$senderId"}, receiver_id: {_eq: "$receiverId"}}, {receiver_id: {_eq: "$senderId"}, sender_id: {_eq: "$receiverId"}}]}, order_by: {created_at: desc}, limit: $limit) {
    message
    is_receiver_read
    id
    receiver_id
    sender_id
  }
}


''';
}
