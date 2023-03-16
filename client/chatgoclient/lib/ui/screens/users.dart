import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/search.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/ui/widgets/common/empty_screen.dart';
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
              firstPageErrorIndicatorBuilder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextManger.instance.randomError,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 60,
                        height: SizeConfig.safeBlockVertical * 5,
                        child: ElevatedButton(
                            onPressed: () {
                              SearchController.instance.pageController
                                  .retryLastFailedRequest();
                            },
                            child: Text(TextManger.instance.retry)),
                      )
                    ],
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return const EmptyBox();
              },
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
