import 'package:chatgoclient/manager/text.dart';
import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Text(
            '😅',
            style: TextStyle(fontSize: 100),
          ),
          Text(
            TextManger.instance.emptyBoxText,
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }
}
