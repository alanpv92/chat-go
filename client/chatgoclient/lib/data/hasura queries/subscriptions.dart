class HasuraSubscriptions {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static String getUserSenderSubscription(
          {required String senderId, required String receiverId}) =>
      '''

subscription watchUserSenderChat {
  chats(where: {_or: [{sender_id: {_eq: "$senderId"}, receiver_id: {_eq: "$receiverId"}}, {receiver_id: {_eq: "$senderId"}, sender_id: {_eq: "$receiverId"}}]}, limit: 1, order_by: {created_at: desc}) {
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
  chatpreview(where: {_or: [{user_1_id: {_eq: "$senderId"}}, {user_2_id: {_eq: "$senderId"}}]}) {
    id
    chat {
      message
      receiver_id
      sender_id
      is_receiver_read
      user {
        user_name
      }
      userBySenderId {
        user_name
      }
    }
  }
}
''';
//////////////////////////////////////////////////////////////////////////////////
}
