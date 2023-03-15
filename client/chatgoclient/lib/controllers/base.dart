import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  bool isloading = false;
  setLoadingStatus(bool newStatus) {
    isloading = newStatus;
    notifyListeners();
  }
}
