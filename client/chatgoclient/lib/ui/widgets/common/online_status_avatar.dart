import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';

import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class OnlineStatusAvatar extends StatefulWidget {
  final String userId;
  final String userName;

  const OnlineStatusAvatar(
      {super.key, required this.userName, required this.userId});

  @override
  State<OnlineStatusAvatar> createState() => _OnlineStatusAvatarState();
}

class _OnlineStatusAvatarState extends State<OnlineStatusAvatar> {
  bool loadingSnapShot = true;
  late final Snapshot? _snapshot;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        
      _snapshot = await UserMangementController.instance
          .getSingleUserStatusSnapSnot(userId: widget.userId);
      setState(() {
        loadingSnapShot = false;
      });
    });
    super.initState();
  }



  @override
  void dispose() {
    _snapshot?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: loadingSnapShot ? null : _snapshot,
      builder: (context, data) {
        if (data.connectionState == ConnectionState.active &&
            data.hasData &&
            !data.hasError) {
          final status =
              (data.data['data']['useronlinestatus'] as List).isNotEmpty;

          return !status
              ? CircleAvatar(
                  child: Text(widget.userName[0]),
                )
              : Stack(
                  children: [
                    CircleAvatar(
                      child: Text(widget.userName[0]),
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
          child: Text(widget.userName[0]),
        );
      },
    );
  }
}
