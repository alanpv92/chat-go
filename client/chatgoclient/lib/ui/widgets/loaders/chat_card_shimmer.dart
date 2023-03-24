import 'package:chatgoclient/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatCardShimmerLoader extends StatelessWidget {
  const ChatCardShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
              leading:const CircleAvatar(),
              title: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child:  SizedBox(height: SizeConfig.blockSizeVertical*5,),
              ));
        },
      ),
    );
  }
}

