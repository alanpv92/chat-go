class HasuraSubscriptions {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static String getUserSenderSubscription(
          {required String senderId, required String receiverId}) =>
      '''

subscription watchUserSenderChat {
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

///////////////////////////////////////////////////////////////////////////////////////////////

  static getChatPreviewSubScription({required String senderId}) => '''
subscription getChatPreview {
  users {
    chats(where: {receiver_id: {_eq: "$senderId"}}, limit: 1, order_by: {created_at: desc}) {
      message
      sender_id
      is_receiver_read
      user {
        user_name
      }
    }
  }
}


''';
//////////////////////////////////////////////////////////////////////////////////
}
