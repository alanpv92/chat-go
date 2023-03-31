class HasuraMutation {
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String updateReadStatus(
          {required String senderId, required String receiverId}) =>
      '''

mutation updateChatReadStatus {
  update_chats(where: {receiver_id: {_eq: "$receiverId"}, sender_id: {_eq: "$senderId"}, is_receiver_read: {_eq: false}}, _set: {is_receiver_read: true}) {
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

  static String addUserStatus({required String userId}) => '''

   mutation addUserStatus {
  insert_useronlinestatus_one(object: {user_id: "$userId", status: true}, on_conflict: {constraint: useronlinestatus_pkey, update_columns: updated_at}) {
    status
  }
}


 ''';

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String removeUserStatus({required String userId}) => '''

  mutation removeUserStatus {
  delete_useronlinestatus(where: {user_id: {_eq: "$userId"}}) {
    affected_rows
  }
}

''';

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String insertUserNotificationToken(
          {required String token, required String userId}) =>
      '''


 mutation insertNotificationToken {
  insert_usernotifications_one(object: {notification_token: "$token", user_id: "$userId"}) {
    id
  }
}




''';

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String updateUserNotificationToken(
          {required String userId, required String token}) =>
      '''

mutation updateUserNotificationToken {
  update_usernotifications(where: {user_id: {_eq: "$userId"}}, _set: {notification_token: "$token"}) {
    affected_rows
  }
}

   

''';

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String deleteUserNotificationToken({required String userId}) => '''


mutation deleteUserNotificationToken {
  delete_usernotifications(where: {user_id: {_eq: "$userId"}}) {
    affected_rows
  }
}



''';

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
