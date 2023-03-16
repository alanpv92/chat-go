import 'package:chatgoclient/controllers/search.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/ui/widgets/search/search_bar.dart';
import 'package:chatgoclient/ui/widgets/search/user_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    SearchController.instance.initPageController();
    super.initState();
  }

  @override
  void dispose() {
    SearchController.instance.disposePageController();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextManger.instance.searchUserScreenTitle),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SearchBar(isRedirect: true),
          Expanded(
              child: PagedListView.separated(
            pagingController: SearchController.instance.pageController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (context, item, index) {
                if (item.userId ==
                    UserMangementController.instance.user.userId) {
                  return const SizedBox();
                }
                return UserCard(
                  user: item,
                );
              },
            ),
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 2,
              );
            },
          ))
        ],
      )),
    );
  }
}
