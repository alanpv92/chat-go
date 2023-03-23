class HasuraMutation {
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String updateReadStatus({required String senderId,required String receiverId}) => '''

mutation updateIsReadStatus {
  update_chats(where: {receiver_id: {_eq: "$receiverId"}, is_receiver_read: {_eq: false}, sender_id: {_eq: "$senderId"}}, _set: {is_receiver_read: true}) {
    affected_rows
  }
}

''';

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String updateSingleChatByPk({required String chatId}) => '''

mutation updateReadStatusForSingleChat {
  update_chats_by_pk(pk_columns: {id: "$chatId"}, _set: {is_receiver_read: true}) {
    id
  }
}



''';

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
