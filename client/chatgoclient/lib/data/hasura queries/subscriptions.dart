class HasuraSubscriptions {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static String getUserSenderSubscription(
          {required String senderId, required String receiverId}) =>          
'''

subscription watchUserSenderChat {
  chats(where: {sender_id: {_eq: "2777c110-aff9-4efe-a5b1-6675676c2ba6"}, receiver_id: {_eq: "fc8b5dd5-4f8a-47c9-840a-743558b7bf0f"}}) {
    message
    is_receiver_read
    id
  }
}


''';


///////////////////////////////////////////////////////////////////////////////////////////////
}
