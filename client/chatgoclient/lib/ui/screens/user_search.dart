

import 'package:chatgoclient/controllers/search.dart';
import 'package:chatgoclient/ui/widgets/common/empty_screen.dart';
import 'package:chatgoclient/ui/widgets/search/search_bar.dart';
import 'package:chatgoclient/ui/widgets/search/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSearchScreen extends StatelessWidget {
  const UserSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SearchBar(),
          Expanded(child: Consumer(
            builder: (context, ref, child) {
              final searchController = ref.watch(searchProvider);
              return searchController.isloading 
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  :searchController.searchResult.isEmpty?const EmptyBox() :ListView.separated(
                      itemBuilder: (context, index) {
                        return UserCard(
                            user: searchController.searchResult[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: searchController.searchResult.length);
            },
          ))
        ],
      )),
    );
  }
}
