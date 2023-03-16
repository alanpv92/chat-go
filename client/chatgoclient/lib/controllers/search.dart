import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/network/hasura/users.dart';
import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/models/user.dart';

final searchProvider = ChangeNotifierProvider((ref) => SearchController());

class SearchController extends BaseController {
  SearchController._();
  static SearchController instance = SearchController._();
  factory SearchController() => instance;
  final UsersHasuraService _usersHasuraService = UsersHasuraService();
  late PagingController<int, User> _pagingController;
  int numberOfitemsPerFetch = 10;

  PagingController<int, User> get pageController => _pagingController;

  final List<User> _searchResult = [];

  List<User> get searchResult => _searchResult;

  initPageController() {
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(offset: pageKey);
    });
  }

  disposePageController() {
    _pagingController.dispose();
  }

  _fetchPage({required int offset}) async {
    try {
     
      final response =
          await _usersHasuraService.getAllUsers(offset: offset, limit: 10);
      response.fold((l) {
        _pagingController.error = l.message;
      }, (r) {
        final List userData = r['users'];
        final List<User> users = userData.map((e) => User.fromJson(e)).toList();

        bool isLastPage = users.length < numberOfitemsPerFetch;
        if (isLastPage) {
          _pagingController.appendLastPage(users);
        } else {
          _pagingController.appendPage(users, offset + numberOfitemsPerFetch);
        }
      });
    } catch (e) {
      _pagingController.error = TextManger.instance.randomError;
    }
  }

  searchUserByQuery({required String searchQuery}) async {
    _searchResult.clear();
    if (searchQuery == "") {
      setLoadingStatus(false);
      return;
    }

    final response = await _usersHasuraService.getUsersBySearchQuery(
        searchQuery: searchQuery);

    response.fold((l) {
      _searchResult.clear();
      CustomSnackBar.instance
          .showError(errorText: TextManger.instance.randomError);
      Get.back();
    }, (r) {
      final List userData = r['users'];

      final List<User> users = userData.map((e) => User.fromJson(e)).toList();
      _searchResult.addAll(users);

      setLoadingStatus(false);
    });
  }
}
