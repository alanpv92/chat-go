import 'package:chatgoclient/controllers/search.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({super.key});

  @override
  State<SearchUsersScreen> createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
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
          Expanded(
              child: PagedListView.separated(
            pagingController: SearchController.instance.pageController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (context, item, index) {
                if (item.userId ==
                    UserMangementController.instance.user.userId) {
                  return const SizedBox();
                }
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(item.userName[0]),
                  ),
                  title: Text(
                    item.userName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      item.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
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
