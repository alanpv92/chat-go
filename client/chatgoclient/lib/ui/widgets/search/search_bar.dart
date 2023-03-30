import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/search.dart';
import 'package:chatgoclient/manager/route.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/utils/debouncer.dart';

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

class SearchBar extends StatefulWidget {
  final bool isRedirect;
  const SearchBar({super.key, this.isRedirect = false});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController searchQueryEditingController;
  @override
  void initState() {
    searchQueryEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchQueryEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
        width: double.infinity,
        margin: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 2,
            right: SizeConfig.safeBlockHorizontal * 2,
            top: SizeConfig.safeBlockVertical * 2),
        child: Card(
          elevation: 8,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          child: TextFormField(
            controller: searchQueryEditingController,
            autofocus: !widget.isRedirect,
            onTap: () {
              if (widget.isRedirect) {
                Get.toNamed(Routes.searchUserScreen);
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              }
            },
            onChanged: (value) {
              SearchController.instance.setLoadingStatus(true);
              MyDebouncer().fireApi(SearchController.instance.searchUserByQuery,
                  searchQueryEditingController);
            },
            decoration: InputDecoration(
                prefixIcon: !widget.isRedirect
                    ? IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close))
                    : null,
                hintText: TextManger.instance.searchUserNameText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)),
          ),
        ));
  }
}
