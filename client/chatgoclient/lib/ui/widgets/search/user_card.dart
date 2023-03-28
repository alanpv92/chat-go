

import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/ui/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hasura_connect/hasura_connect.dart';

class UserCard extends StatefulWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late Snapshot? snapshot;
  bool loadingSnapShot = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      snapshot = await UserMangementController.instance
          .getSingleUserStatusSnapSnot(userId: widget.user.userId);
      setState(() {
        loadingSnapShot = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    snapshot?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => ChatScreen(
            chatPreview: ChatPreview.getFromUser(user: widget.user)));
      },
      leading: StreamBuilder(
        stream: loadingSnapShot ? null : snapshot,
        builder: (context, data) {
          if (data.connectionState == ConnectionState.active &&
              data.hasData &&
              !data.hasError) {
            final status = (data.data['data']['useronlinestatus'] as List).isNotEmpty;
     
            return !status
                ? CircleAvatar(
                    child: Text(widget.user.userName[0]),
                  )
                : Stack(
                    children: [
                      CircleAvatar(
                        child: Text(widget.user.userName[0]),
                      ),
                      Positioned(
                          bottom: 2,
                          right: 2,
                          child: CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            radius:
                                SizeConfig.safeBlockHorizontal * 1.2.toDouble(),
                          ))
                    ],
                  );
          }
          return CircleAvatar(
            child: Text(widget.user.userName[0]),
          );
        },
      ),
      title: Text(
        widget.user.userName,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          widget.user.email,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
