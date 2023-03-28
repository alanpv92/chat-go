import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/size_config.dart';

class ChatScreenShimmerLoader extends StatelessWidget {
  const ChatScreenShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Align(
              alignment:
                  index % 2 == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
              child: SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 35,
                  height: SizeConfig.safeBlockVertical * 5,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [],
                      ),
                    ),
                  )));
        },
        itemCount: 20,
      ),
    );
  }
}
